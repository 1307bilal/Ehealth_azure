resource "azurerm_resource_group" "ehealth_rg" {
  name     = "ehealth-resources"
  location = "West Europe"
}

module "net" {
  source = "./module_vnet"
}


/** resource "azurerm__network_security_group" "ehealth_security_group_in_nlb_web" {
  name                = var.network_security_group_in_nlb_web
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "http_node1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = module.module_vnet.public_ip_id
    destination_address_prefix = "10.0.1.0/24"
  }

  security_rule {
    name                       = "https_node1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = module.module_vnet.public_ip_id
    destination_address_prefix = "10.0.1.0/24"
  }

  security_rule {
    name                       = "http_node2"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = module.module_vnet.public_ip_id
    destination_address_prefix = "10.0.4.0/24"
  }

  security_rule {
    name                       = "https_node2"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = module.module_vnet.public_ip_id
    destination_address_prefix = "10.0.4.0/24"
  }

}
**/

resource "azurerm_network_security_group" "ehealth_security_group_web" {
  name                = var.network_security_group_web
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = module.module_vnet.public_ip_id
    destination_address_prefix = "10.0.1.0/24"
  }

  security_rule {
    name                       = "https"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = module.module_vnet.public_ip_id
    destination_address_prefix = "10.0.1.0/24"
  }

resource "azurerm__network_security_group" "ehealth_security_group_logic" {
  name                = var.network_security_group_logic
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  security_rule {
    name                       = "http"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "80"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "10.0.2.0/24"
  }
  security_rule {
    name                       = "https"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "443"
    destination_port_range     = "443"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "10.0.2.0/24"
  }
  security_rule {
    name                       = "mysql"
    priority                   = 104
    direction                  = "outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3306"
    destination_port_range     = "3306"
    source_address_prefix      = "10.0.2.0/24"
    destination_address_prefix = "10.0.3.0/24"
  }
  tags = {
    environment = "Production"
  }
}

resource "azurerm__network_security_group" "ehealth_security_group_data" {
  name                = var.network_security_group_data
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  security_rule {
    name                       = "mysql"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "10.0.2.0/24"
    destingiation_address_prefix = "10.0.3.0/24"
  }

  tags = {
    environment = "Production"
  }
}




resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = module.module_vnet.subnet_prefixes[0]
  network_security_group_id = azurerm_network_security_group.ehealth_security_group_web
}

resource "azurerm_subnet_network_security_group_association" "logic" {
  subnet_id                 = module.module_vnet.subnet_prefixes[1]
  network_security_group_id = azurerm_network_security_group.ehealth_security_group_logic
}

resource "azurerm_subnet_network_security_group_association" "data" {
  subnet_id                 = module.module_vnet.subnet_prefixes[2]
  network_security_group_id = azurerm_network_security_group.ehealth_security_group_data
}

/**
resource "azurerm_lb" "ehealthLB" {
  name                = "EhealthtLoadBalancer"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = module.module_vnet.public_ip_id
  }
}**/
