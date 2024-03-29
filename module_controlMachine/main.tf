
resource "azurerm_resource_group" "control-rg" {
  name = var.resource_group_name
  location = var.resource_group_location

  tags = {
    environment = "control"
  }
}

resource "azurerm_virtual_network" "control-vnet" {
  name = var.virtual_network_name
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.control-rg.location
  resource_group_name = azurerm_resource_group.control-rg.name
  tags = {
    environment = "control"
  }
}

resource "azurerm_subnet" "control-subnet" {
  name = var.subnet_name
  resource_group_name = azurerm_resource_group.control-rg.name
  virtual_network_name = azurerm_virtual_network.control-vnet.name
  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "control-public-ip" {
  name = var.public_ip_name
  resource_group_name = azurerm_resource_group.control-rg.name
  location = azurerm_resource_group.control-rg.location
  allocation_method = "Dynamic"
  tags = {
    environment = "control"
  }
}

resource "azurerm_network_security_group" "control-nsg" {
  name = var.network_security_group_name
  location = azurerm_resource_group.control-rg.location
  resource_group_name = azurerm_resource_group.control-rg.name

  security_rule {
    name = "SSH"
    priority = 1001
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "control"
  }
}

resource "azurerm_network_interface" "control-nic"{
  name = var.network_interface_name
  location = azurerm_resource_group.control-rg.location
  resource_group_name = azurerm_resource_group.control-rg.name

  ip_configuration {
    name = "control-nic-config"
    subnet_id = azurerm_subnet.control-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.control-public-ip.id
  }

  tags = {
    environment = "control"
  }
}

resource "azurerm_network_interface_security_group_association" "control-sg-association" {
  network_interface_id = azurerm_network_interface.control-nic.id
  network_security_group_id = azurerm_network_security_group.control-nsg.id
}

resource "random_id" "control-randomId" {
  keepers = {
    resource_group = azurerm_resource_group.control-rg.name
  }
  byte_length = 8
}

resource "azurerm_storage_account" "control-storage" {
  name = "diag${random_id.control-randomId.hex}"
  resource_group_name = azurerm_resource_group.control-rg.name
  location = azurerm_resource_group.control-rg.location
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "control"
  }
}

resource "tls_private_key" "control_machine_key_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "azurerm_linux_virtual_machine" "control-vm" {
  name = var.control_machine_name
  resource_group_name = azurerm_resource_group.control-rg.name
  location = azurerm_resource_group.control-rg.location
  network_interface_ids = [azurerm_network_interface.control-nic.id]
  size = "Standard_DS1_v2"

  os_disk {
    name = "myOsDisk"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }

  computer_name = "control-vm"
  admin_username = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username = "azureuser"
    public_key = tls_private_key.control_machine_key_ssh.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.control-storage.primary_blob_endpoint
  }

  tags = {
    environment = "control"
  }
}
