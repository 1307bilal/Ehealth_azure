output "resource_group_name" {
  description = "Name of ehealth resource group to be imported."
  value = azurerm_resource_group.ehealth_rg.name
}

output "resource_group_location" {
  description = "Location of ehealth resource group"
  value = azurerm_resource_group.ehealth_rg.location
}

# NSGs

output "network_security_group_web" {
  description = "Name of the security group rules for web layer"
  value = azurerm_network_security_group.ehealth_security_group_web.name
}

output "network_security_group_logic" {
  description = "Name of the security grouo rules for logic layer"
  value = azurerm_network_security_group.ehealth_security_group_logic.name
}

output "network_security_group_data" {
  description = "Name of the security group rules for data layer"
  value = azurerm_network_security_group.ehealth_security_group_data.name
}

#NSG associations

output "NSG_group_association_web" {
  description = "Name of the association for web layer"
  value = azurerm_subnet_security_group_association.web
}

output "NSG_group_association_logic" {
  description = "Name of the association for logic layer"
  value = azurerm_subnet_security_group_association.logic
}

output "NSG_group_association_data" {
  description = "Name of the association for data layer"
  value = azurerm_subnet_security_group_association.data
}

/**output "network_security_group_nlb" {
  description = "Name of the security group rules for the load balancer"
  value = azurerm__network_security_group.ehealth_security_group_in_nlb_web.name
}

output "NSG_group_association_NLB" {
  description = "Name of the association for the load balancer"
  value = azurerm_network_security_group.ehealth_security_group_in_nlb_web.name
}
**/