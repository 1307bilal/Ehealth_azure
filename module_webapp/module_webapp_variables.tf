variable "webapp_name" {
  type = string
  description = "The name of the Web application to be deployed"
}

variable "java_server_version" {
  type = string
  description = "The version of the Java Server"
}

variable "resource_group_name" {
   type = string
   description = "The resource group name"
}

variable "location" {
  type = string
  description = "The location"
}