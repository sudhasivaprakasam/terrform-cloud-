#how to create a resource group. 
resource "azurerm_resource_group" "myrg" { #this is the refrence it will be managed by terraform to store your logs
  name = "${local.resource_name_prefix}-${var.resource_group_name}"
  #sap-dev-rg-default
  location = var.resource_group_location
  tags     = local.common_tags
}
/*
*/