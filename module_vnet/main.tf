resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  count = length(var.subnet_names)
  name = var.subnet_names[count.index]
  resource_group_name = data.azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [var.subnet_prefixes[count.index]]
}

locals {
  azurerm_subnet = {
    for index, subnet in azurerm_subnet.subnet :
    subnet.name => subnet.id
  }
}