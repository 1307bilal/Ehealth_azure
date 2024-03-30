#GLOBAL

variable "resource_group_location" {
  type = string
  description = "RG location in Azure for the entire project"
}

variable "resource_group_name" {
  type = string
  description = "Control RG name in Azure"
}

#--------------------------------------------------------------------------------

variable "virtual_network_name" {
  type = string
  description = "Control VNET name in Azure"
  default = "control-vnet"
}

variable "subnet_name" {
  type = string
  description = "Control Subset name in Azure"
  default = "control-subnet"
}

variable "public_ip_name" {
  type = string
  description = "Control Public IP name in Azure"
  default = "control-ip"
}

variable "network_security_group_name" {
  type = string
  description = "Control NSG name in Azure"
  default = "control-nsg"
}

variable "network_interface_name" {
  type = string
  description = "Control NIC name in Azure"
  default = "control-nic"
}

variable "control_machine_name" {
  type = string
  description = "Control VM name in Azure"
  default = "control-vm"
}