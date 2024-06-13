/*resource "azurerm_public_ip" "mypublicip" {
  count = 2
  #count will always accept a whole number
  #the public ip name need to be unique
  name = "${local.resource_name_prefix}-publicip-${count.index}"
  #zero
  #sap-dev-publicip-0 sap-dev-publicip-1
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method = "Static"
  tags = local.common_tags
}
*/
##once we created the public 
#lets create the nic  car
resource "azurerm_network_interface" "myvmnic" {
  for_each = var.force_map
  name = "${local.resource_name_prefix}-nic-${each.key}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name = "internal"
    #nic car will get private ip 
    subnet_id = azurerm_subnet.web_subnet.id 
    private_ip_address_allocation = "Dynamic"
    #there are two public ip list of item and i need to do the iteration in list of items
    #i need to provide the list of value and terraform can pick the same. 
    #public_ip_address_id = element(azurerm_public_ip.mypublicip[*].id,count.index) 
  }
}