<<<<<<< HEAD
output "resource_group_name" {
  description = "Name of ehealth resource group to be imported."
  value = azurerm_resource_group.ehealth_rg.name
}

output "resource_group_location" {
  description = "Location of ehealth resource group"
  value = azurerm_resource_group.ehealth_rg.location
}

output "network_security_group_web" {
  description = "Name of the security group rules for web layer"
  value = azurerm__network_security_group.ehealth_security_group_web.name
}

output "network_security_group_logic" {
  description = "Name of the security grouo rules for logic layer"
  value = azurerm__network_security_group.ehealth_security_group_logic.name
}

output "network_security_group_data" {
  description = "Name of the security group rules for data layer"
  value = azurerm__network_security_group.ehealth_security_group_data.name
}

output "network_security_group_nlb" {
  description = "Name of the security group rules for data layer"
  value = azurerm__network_security_group.ehealth_security_group_in_nlb_web.name
=======
output "webapp_url" {
  value = module.webapp.webapp_url
}

output "webapp_ips" {
  value = module.webapp.webapp_ips
}

output "mysql_db_name" {
  value = module.webapp.mysql_db_name
>>>>>>> main
}