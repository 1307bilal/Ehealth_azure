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

module "storage" {
  source              = "./modules_storage"
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_resource_group.rg]
}

module "webapp" {
  source              = "./module_webapp" #"github.com/1307bilal/Ehealth_azure/module_webapp"
  resource_group_name = var.resource_group_name
  location            = var.location
  webapp_name         = var.webapp_name
  java_server_version = var.java_server_version
  service_plan_name = var.service_plan_name
}