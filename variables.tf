variable "resource_group_name" {

  description = "Name of the resource group to be imported."
  type = string
}

variable "resource_group_location" {
  description = "Location of ehealth resource group"
  type = string
}

variable "network_security_group_web" {
  description = "The security group rules for web layer"
  type = string
}

variable "network_security_group_logic" {
  description = "The security grouo rules for logic layer"
  type = string
}

variable "network_security_group_data" {
  description = "The security group rules for data layer"
  type = string
}

variable "network_security_group_in_nlb_web" {
  description = "The security group rules for data layer"
  type = string
}

variable "location" {
  type        = string
  description = "The location "
}

# Web application variables section
variable "webapp_name" {
  type        = string
  description = "The name of the web application"
}

variable "java_server_version" {
  type        = string
  description = "The java version"
}



variable "service_plan_name" {
  type        = string
  description = "The name of the service plan"
}

variable "mysqlserver_name" {
  type        = string
  description = "The name of the MySql server"
}

variable "mysqladmin_login" {
  type        = string
  description = "The mysql server administrator login"
  sensitive   = true
}

variable "mysqladmin_password" {
  type        = string
  description = "The mysql server administrator password"
  sensitive   = true
}

variable "mysql_db_name" {
  type        = string
  description = "The mysql database name"

}