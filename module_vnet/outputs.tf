output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the newly created vNet"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.vnet.location
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.vnet.address_space
}

output "vnet_subnets" {
  description = "The ids of subnets created inside the new vNet"
  value       = azurerm_subnet.subnet.*.id
}

output "public_ip_id" {
  description = "Public IP in Azure"
  value       = azurerm_public_ip.public_ip.id
}