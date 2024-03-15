#Azure Generic storage Module
data "azurerm_resource_group" "storage" {
  name = var.resource_group_name
}

 resource "azurerm_storage_account" "storage" {
   name                     = "ehealthserviceaccount"
   resource_group_name      = var.resource_group_name
   location                 = var.resource_group_location
   account_tier             = "Standard"
   account_replication_type = "LRS"

   tags = {
     environment = "production"
   }
 }

resource "azurerm_mssql_server" "sql" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  version                      = "12.0"
  minimum_tls_version          = "1.2"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
  depends_on                   = [azurerm_storage_account.storage]
}

resource "azurerm_mssql_database" "db" {
  name                = var.sql_database_name
  server_id           = azurerm_mssql_server.sql.id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  license_type        = "LicenseIncluded"
  sku_name            = "S0"
  zone_redundant      = false
  depends_on          = [azurerm_mssql_server.sql]
}
