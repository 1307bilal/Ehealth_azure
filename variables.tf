variable "resource_group_name" {
  type        = string
  description = "The resource group name"
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