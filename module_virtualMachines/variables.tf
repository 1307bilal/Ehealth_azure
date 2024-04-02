variable "resource_group_name" {
  type        = string
  description = "The resource group name"
}

variable "resource_group_location" {
  type        = string
  description = "The resource group location"
}

variable "infra_name" {
  type        = string
  description = "The infrastructure name"
}

variable "vms" {
  type        = list(string)
  description = "The list of virtual machines to be created"
}