provider "azurerm" {
  features {}
  alias           = "management01"
  subscription_id = var.subscription_id
}

data "azurerm_resource_group" "asprg" {
  name = var.app_service_plan_rg_name
}

data "azurerm_resource_group" "apprg" {
  name = var.app_service_rg_name
}

data "azurerm_service_plan" "asp" {
  provider                = azurerm.management01
  name                = var.app_service_plan_name
  resource_group_name = data.azurerm_resource_group.asprg.name
}

data "azurerm_windows_web_app" "windows_webapp" {
  provider                = azurerm.management01
  name                    = var.app_service_name
  resource_group_name     = data.azurerm_resource_group.apprg.name
}

resource "azurerm_monitor_action_group" "action" {
  name                = "DevActionGroup"
  resource_group_name = data.azurerm_resource_group.apprg.name
  short_name          = "DevActGroup"
  email_receiver {
    name                    = "EmailReceiver"
    email_address           = "solutionsd999@gmail.com"
  }
}

# CPU Usage Alert
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "CPUUsageAlert"
  resource_group_name = data.azurerm_resource_group.apprg.name
  scopes              = [data.azurerm_windows_web_app.windows_webapp.id]
  description         = "Alert when CPU usage exceeds 80%"
  target_resource_type = "Microsoft.Web/sites"
  severity            = 1
  
  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "CPU percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.action.id
  }
}

# Memory Usage Alert
resource "azurerm_monitor_metric_alert" "memory_alert" {
  name                = "MemoryUsageAlert"
  resource_group_name = data.azurerm_resource_group.apprg.name
  scopes              = [data.azurerm_windows_web_app.windows_webapp.id]
  description         = "Alert when memory usage exceeds 80%"
  target_resource_type = "Microsoft.Web/sites"
  severity            = 1
  
  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "MemoryWorkingSet"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.action.id
  }
}

# Response Time Alert
resource "azurerm_monitor_metric_alert" "response_time_alert" {
  name                = "ResponseTimeAlert"
  resource_group_name = data.azurerm_resource_group.apprg.name
  scopes              = [data.azurerm_windows_web_app.windows_webapp.id]
  description         = "Alert for response time exceeding threshold"
  target_resource_type = "Microsoft.Web/sites"
  
  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "AverageResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 500 # Example threshold in milliseconds
  }

  action {
    action_group_id = azurerm_monitor_action_group.action.id
  }
}



resource "azurerm_monitor_metric_alert" "ssl_certificate_expiry_alert" {
  name                = "SSLCertificateExpiryAlert"
  resource_group_name = data.azurerm_resource_group.apprg.name
  scopes              = [data.azurerm_windows_web_app.windows_webapp.id]
  description         = "Alert when SSL certificate is expired"
  target_resource_type = "Microsoft.Web/sites"

  criteria {
    metric_namespace = "Microsoft.Web/certificates"
    metric_name      = "ExpirationDate"
    aggregation      = "Minute"
    operator         = "LessThan"
    threshold        = "0"
    dimension {
      name     = "CertificateName"
      operator = "Include"
      values   = [data.azurerm_windows_web_app.windows_webapp.site_config.0.linux_fx_version]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.action.id
  }
}