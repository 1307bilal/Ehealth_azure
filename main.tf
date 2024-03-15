resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "Central US"
}

module "vnet" {
  source              = "github.com/1307bilal/Ehealth_azure"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_names        = ["subnet1", "subnet2"]

  depends_on = [azurerm_resource_group.rg]
}


module "webapp" {
  source = "github.com/1307bilal/Ehealth_azure/module_webapp"
}