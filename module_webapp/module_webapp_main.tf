data "azurerm_resource_group" "webapp" {
  name = var.resource_group_name
}

resource "azurerm_linux_web_app" "app" {
  name = var.webapp_name
  resource_group_name = var.resource_group_name
  location = var.location
  service_plan_id = ""

  site_config {
    application_stack {
      java_server_version = var.java_server_version
    }
  }

  app_settings = {}

  connection_string {
    
  }
}