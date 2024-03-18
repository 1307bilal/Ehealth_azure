data "azurerm_resource_group" "webapp" {
  name = var.resource_group_name
}

resource "azurerm_service_plan" "wabapp-srevice-plan" {
  name                = "wabapp_svc_plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1" #"P1v2"
}

resource "azurerm_linux_web_app" "app" {
  name                = var.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.wabapp-srevice-plan.id

  site_config {
    application_stack {
      java_server_version = var.java_server_version
    }
  }

  app_settings = {}

  # connection_string {
  #   name = ""
  # }

}