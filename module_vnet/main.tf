resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  address_space = ["10.0.0.0/16"]
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  count = length(var.subnet_names)
  name = var.subnet_names[count.index]
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [for a in var.subnet_prefixes : a]
}

locals {
  azurerm_subnet = {
    for index, subnet in azurerm_subnet.subnet :
    subnet.name => subnet.id
  }
}

resource "azurerm_public_ip" "public_ip" {
  name = var.public_ip_name
  resource_group_name = var.resource_group_name
  location = var.resource_group_location
  allocation_method = "Dynamic"
}