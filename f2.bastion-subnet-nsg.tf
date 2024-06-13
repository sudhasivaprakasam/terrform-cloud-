/*resource "azurerm_subnet" "bastion_subnet" {
  name                 = "${local.resource_name_prefix}-${var.bastion_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_subnet_address
}



#this is goign to create an nsg
resource "azurerm_network_security_group" "bastion_subnet_nsg" {
    name                 = "${local.resource_name_prefix}-bastionnsg"
  resource_group_name  = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  tags = local.common_tags
}
#nsg need to be mapped with subnet 
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_association" {
    #map the nsg with subnet
  subnet_id = azurerm_subnet.bastion_subnet.id 
  network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id  
}
locals {
    #web_inbound_port name
  bastion_inbound_port = {
    "110" : "22", #all this are key value expression
    "120" : "3389"
    
  }
}
#inside nsg we will create rule 
resource "azurerm_network_security_rule" "bastion_nsg_rule_inbound" {
    for_each = local.bastion_inbound_port
  name                        = "Rule-Port-${each.value}" #Reule-Port-80
  priority                    = each.key #110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value #80
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
 resource_group_name  = azurerm_resource_group.myrg.name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}*/