variable "webapp_name" {
  type        = string
  description = "The name of the Web application to be deployed"
}

variable "java_server_version" {
  type        = string
  description = "The version of the Java Server"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name"
}

variable "location" {
  type        = string
  description = "The location"
}

variable "service_plan_name" {
  type = string
  description = "The name of the service plan"
}

# Mysql

variable "mysqlserver_name" {
  type = string
  description = "The Mysql server name"
}

variable "mysqladmin_login" {
  type = string
  description = "The admin login of tMysqm server"
  sensitive = true
}

variable "mysqladmin_password" {
  type = string
  description = "The mysql server administrator password"
  sensitive = true
}

variable "mysql_db_name" {
  type = string
  description = "The mysql database name"
}