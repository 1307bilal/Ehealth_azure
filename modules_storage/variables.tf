variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "resource_group_location" {
  description = "Name of location to be imported."
  type        = string
  default     = "centralus"
}

variable "sql_server_name" {
  type        = string
  description = "SQL Server instance name in Azure"
  default     = "ehealth-sqlserver13"
}

variable "sql_database_name" {
  type        = string
  description = "SQL Database name in Azure"
  default     = "ehealth-db13"
}

variable "sql_admin_login" {
  type        = string
  description = "SQL Server login name in Azure"
  default     = "user"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL Server password name in Azure"
  default     = "p@ssword13"
}
