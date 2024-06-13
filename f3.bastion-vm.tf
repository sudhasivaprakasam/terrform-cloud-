/*resource "azurerm_public_ip" "bastion_publicip" {
  
  name = "${local.resource_name_prefix}-bastionpublicip"
 
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method = "Static"
  sku = "Standard" #premium
  tags = local.common_tags
}

resource "azurerm_network_interface" "bastionvmnic" {
 
  name = "${local.resource_name_prefix}-bastionnic"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name = "internal"
    #nic car will get private ip 
    subnet_id = azurerm_subnet.bastion_subnet.id 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.bastion_publicip.id
    #public_ip_address_id = element(azurerm_public_ip.mypublicip[*].id,count.index) 
  }
}

resource "azurerm_linux_virtual_machine" "bastionlinuxvm" {
  name                = "${local.resource_name_prefix}-bastionvm"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  size                = "Standard_F2"
  admin_username      = "azureuser"
  #when we create the vm the vm will be attached with my nic card
  #when i create teh first vm the vm should pick first nic card it should pick the second nic
  network_interface_ids = [
    #this nic card has list of values
    azurerm_network_interface.bastionvmnic.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    #when i want to upload the public key 
    #i know that my public key is in current directory terraform has come up with a function
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  os_disk {
    name = "osdisk-bastion"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
 
}*/