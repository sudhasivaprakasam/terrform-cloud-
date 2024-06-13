
/*#if i created a block called null_resource any activity i do will not be stored in state file
resource "null_resource" "copy_ssh" {
  depends_on = [ azurerm_linux_virtual_machine.bastionlinuxvm ]
  #this null resource will not excute till my virtual machine is created
  #mariadb server
  connection {
    type = "ssh" #RDP
    host = azurerm_linux_virtual_machine.bastionlinuxvm.public_ip_address
    user = azurerm_linux_virtual_machine.bastionlinuxvm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }
  provisioner "file" {
    source = "ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem"
    #we will upload the dumps sql
  }

  provisioner "remote-exec" {
    inline = [ 
        "sudo chmod 400 /tmp/terraform-azure.pem"
        #"java jar agent.jar"
        #i can import the dumps inside the mysql database
     ]
  }
}*/