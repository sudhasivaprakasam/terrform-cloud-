terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  #
  # delete_vm_but_do_not_delete_storage
  subscription_id = var.subscription_id 
  client_id =  var.client_id
  client_secret =  var.client_secret
  tenant_id =  var.tenant_id
}

variable "client_id" {
  type = string 
}
variable "client_secret" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}


