output "control_vm_id" {
  value = azurerm_linux_virtual_machine.control-vm.id
}

output "control_vm_ip" {
  value = azurerm_linux_virtual_machine.control-vm.public_ip_address
}

output "control_machine_key_ssh" {
  value = tls_private_key.control_machine_key_ssh.private_key_pem
  sensitive = true
}