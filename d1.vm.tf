resource "azurerm_linux_virtual_machine" "mylinuxvm" {
  for_each = var.force_map 
  name                = "${local.resource_name_prefix}-vm-${each.key}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  size                = "Standard_F2"
  admin_username      = "azureuser"
  #when we create the vm the vm will be attached with my nic card
  #when i create teh first vm the vm should pick first nic card it should pick the second nic
  network_interface_ids = [
    #this nic card has list of values
    azurerm_network_interface.myvmnic[each.key].id
  ]

  admin_ssh_key {
    username   = "azureuser"
    #when i want to upload the public key 
    #i know that my public key is in current directory terraform has come up with a function
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  os_disk {
    name = "osdisk-${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app/app.sh")
}