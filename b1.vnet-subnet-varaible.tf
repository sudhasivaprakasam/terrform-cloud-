variable "vnet_name" {
  type    = string
  default = "vnet-default"
}

variable "vnet_address_space" {
  type    = list(string) #it is an array format
  default = ["10.0.0.0/16"]
}