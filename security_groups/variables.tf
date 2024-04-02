variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "resource_group_location" {
  description = "Location of ehealth resource group"
  type        = string
}

variable "network_security_group_web" {
  description = "The security group rules for web layer"
  type        = string
}

variable "network_security_group_logic" {
  description = "The security grouo rules for logic layer"
  type        = string
}

variable "network_security_group_data" {
  description = "The security group rules for data layer"
  type = string
}

variable "NSG group association Web"{
  description = "The group association for the web layer"
  type = string

}
variable "NSG group association Logic"{
  description = "The group association for the logic layer"
  type = string
}

variable "NSG group association Data"{
  description = "The group association for the data layer"
  type = string
}

/**variable "network_security_group_in_nlb_web" {
  description = "The security group rules for nlb"
  type = string
}:
**/