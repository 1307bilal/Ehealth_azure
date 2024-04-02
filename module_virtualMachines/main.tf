resource "azurerm_resource_group" "vm-gr" {
  name     = var.resource_group_name
  location = var.resource_group_location

  tags = {
    environment = var.infra_name
  }
}

# Virtual Network
resource "azurerm_virtual_network" "vm-vnet" {
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  name                = "${var.infra_name}-vnet"
  address_space       = ["10.0.0.0/16"]
}

# Subnet
resource "azurerm_subnet" "vm-subnet" {
  count                = length(var.vms)
  resource_group_name  = var.resource_group_name
  name                 = "${var.infra_name}-${var.vms[count.index]}-subnet"
  virtual_network_name = azurerm_virtual_network.vm-vnet.name
  address_prefixes     = ["10.0.${count.index + 1}.0/24"]
}

# NSG- Network Security Group
resource "azurerm_network_security_group" "vm-nsg" {
  count               = length(var.vms)
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  name                = "${var.infra_name}-${var.vms[count.index]}-nsg"
}

# Network Interface
resource "azurerm_network_interface" "vm-network-interface" {
  count               = length(var.vms)
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  name                = "${var.infra_name}-${var.vms[count.index]}-nic"
  ip_configuration {
    name                          = "${var.infra_name}-${var.vms[count.index]}-internal"
    subnet_id                     = azurerm_subnet.vm-subnet[count.index].id
    private_ip_address_allocation = "Dynamic"
  }
}

# NSG Association 
resource "azurerm_network_interface_security_group_association" "vm-nsg-association" {
  network_interface_id      = azurerm_network_interface.vm-network-interface[count.index].id
  network_security_group_id = azurerm_network_security_group.vm-nsg[count.index].id
}