variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "resource_group_location" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet"
  type        = list(string)
  default     = ["subnet-webapp", "subnet-storage"]
}

variable "public_ip_name" {
  description = "Public IP name in Azure"
  type        = string
}