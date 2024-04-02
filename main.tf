resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source                  = "./module_vnet"
  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  vnet_name               = "vnet"
  address_space           = ["10.0.0.0/16"]
  subnet_prefixes         = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_names            = ["subnet-webapp", "subnet-storage"]
  public_ip_name          = "public_ip"
  depends_on              = [azurerm_resource_group.rg]
}

module "security_groups"{
  source                        ="./security_groups"
  resource_group_name           = azurerm_resource_group.rg.name
  resource_group_location       = azurerm_resource_group.rg.location
  network_security_group_web    = var.network_security_group_web
  network_security_group_logic  = var.network_security_group_logic
  network_security_group_data   = var.network_security_group_data
  NSG group association Web     = var.NSG_group_association_Web
  NSG group association Logic   = var.NSG_group_association_Logic
  NSG group association Data    = var.NSG_group_association_Data
  depends_on                    = [azurerm_resource_group]
}

module "storage" {
  source              = "./modules_storage"
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_resource_group.rg]
}

module "webapp" {
  source              = "./module_webapp"                  #"github.com/1307bilal/Ehealth_azure/module_webapp"
  resource_group_name = azurerm_resource_group.rg.name     #var.resource_group_name
  location            = azurerm_resource_group.rg.location #var.location
  webapp_name         = var.webapp_name
  java_server_version = var.java_server_version
  service_plan_name   = var.service_plan_name

  mysqlserver_name    = var.mysqlserver_name
  mysqladmin_login    = var.mysqladmin_login
  mysqladmin_password = var.mysqladmin_password
  mysql_db_name       = var.mysql_db_name
}

module "controlMachine" {
  source                  = "./module_controlMachine"
  resource_group_location = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
}