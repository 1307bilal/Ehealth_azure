 
 /*  data "azurerm_resource_group" "webapp-gr" {
  name = var.resource_group_name
} 
 */

resource "azurerm_service_plan" "webapp-srevice-plan" {
  name                = "webapp-svc-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1" #"P1v2"
}

# Web application
resource "azurerm_linux_web_app" "app" {
  name                = var.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.webapp-srevice-plan.id

  site_config {
    application_stack {
      java_server_version = var.java_server_version
      java_server = "TOMCAT"
      java_version = "17"
    }
  }

  app_settings = {}

  # connection_string {
  #   name = ""
  # }


}

# MySql

resource "azurerm_mysql_server" "ehealth_mysqlserver" {
  name                = var.mysqlserver_name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.mysqladmin_login
  administrator_login_password = var.mysqladmin_password

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "mysql_db" {
  name                = var.mysql_db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.ehealth_mysqlserver.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
    
  }
}



