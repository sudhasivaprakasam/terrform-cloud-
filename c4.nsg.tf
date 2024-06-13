
#this is goign to create an nsg
resource "azurerm_network_security_group" "web_subnet_nsg" {
    name                 = "${local.resource_name_prefix}-nsg"
  resource_group_name  = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  tags = local.common_tags
}
#nsg need to be mapped with subnet 
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
    #map the nsg with subnet
  subnet_id = azurerm_subnet.web_subnet.id 
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id 
}
locals {
    #web_inbound_port name
  web_inbound_port = {
    "110" : "80", #all this are key value expression
    "120" : "443",
    "130": "22"
  }
}
#inside nsg we will create rule 
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
    for_each = local.web_inbound_port
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
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}