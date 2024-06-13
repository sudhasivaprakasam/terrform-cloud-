resource "azurerm_public_ip" "web_lb_publicip" {
  
  name = "${local.resource_name_prefix}-lbpublicip"
 
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method = "Static"
  sku = "Standard" #premium
  tags = local.common_tags
}

#lets create the lb 
resource "azurerm_lb" "web_lb" {
    
  name = "${local.resource_name_prefix}-lbpublicip"
 
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  sku  = "Standard"
  #this lb need to be mapped with your public ip
  frontend_ip_configuration {
    name = "lb"
    public_ip_address_id = azurerm_public_ip.web_lb_publicip.id 
  }
}

#we need to create the backend pool
resource "azurerm_lb_backend_address_pool" "web_lb_pool" {
  name = "${local.resource_name_prefix}-backendpool"
  loadbalancer_id = azurerm_lb.web_lb.id 
}

##we will creat the probes 
resource "azurerm_lb_probe" "web_lb_probe" {
  name = "${local.resource_name_prefix}-probe"
  protocol = "Tcp"
  port = 80
  loadbalancer_id = azurerm_lb.web_lb.id 
  #probe_threshold = 2 #before it will make your instance unhealth
  interval_in_seconds = 15 #every second it will do probes. 
  number_of_probes = 4 #to make your instance unhealth run the probes 4 times
}

#azurerm lb rule 
resource "azurerm_lb_rule" "web_rule" {
 name = "${local.resource_name_prefix}-lbrule"
 protocol = "Tcp"
 frontend_port = 80 
 backend_port = 80 #if i have tomcat server running in the vm
 frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
 backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_pool.id]
 probe_id = azurerm_lb_probe.web_lb_probe.id  
 loadbalancer_id = azurerm_lb.web_lb.id 
}

#finally i need to attach all the nic card to the backend address pool
resource "azurerm_network_interface_backend_address_pool_association" "web_lb_associate" {
  for_each = var.force_map
  network_interface_id = azurerm_network_interface.myvmnic[each.key].id
  ip_configuration_name = azurerm_network_interface.myvmnic[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_pool.id
}