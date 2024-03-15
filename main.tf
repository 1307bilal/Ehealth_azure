resource "azurerm_resource_group" "rg" {
  name     = "my-ehealth-resources"
  location = "Central US"
}

module "vnet" {
  source              = "./module_vnet"
  resource_group_name = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  vnet_name = "vnet"
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_names        = [ "subnet-webapp", "subnet-storage" ]
  public_ip_name = "public_ip"
  depends_on = [azurerm_resource_group.rg]
}