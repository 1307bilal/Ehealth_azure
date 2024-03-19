output "webapp_url" {
  value = azurerm_linux_web_app.app.default_hostname
}

output "webapp_ips" {
  value = azurerm_linux_web_app.app.outbound_ip_addresses
}

output "mysqlserver_name" {
  value = azurerm_mysql_server.ehealth_mysqlserver.name
}

output "mysqladmin_login" {
  value = azurerm_mysql_server.ehealth_mysqlserver.administrator_login
}

output "mysql_db_name" {
  value = azurerm_mysql_database.mysql_db.name
}