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
  
  dynamic "email_receiver" {
    for_each                = var.team_members
    content {
      name                    = email_receiver.key
      email_address           = email_receiver.value
    }
  }
}

# CPU Usage Alert
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "CpuUsageAlert"
  resource_group_name = data.azurerm_resource_group.apprg.name
  scopes              = [data.azurerm_windows_web_app.windows_webapp.id]
  description         = "Triggers an alert when the CPU Time is above 90% for 15 minutes"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "CPUTime"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 90
    #time_aggregation = "PT15M"
    dimension {
      name     = "Instance"
      operator = "Include"
      values   = ["var.app_service_name"]
    }
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
  description         = "Triggers an alert when the MemoryWorkingSet is above 80 Bytes"
  target_resource_type = "Microsoft.Web/sites"
  severity            = 1
  
  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "MemoryWorkingSet"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80

    dimension {
      name     = "Instance"
      operator = "Include"
      values   = ["var.app_service_name"]
    }
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



/*resource "azurerm_monitor_metric_alert" "ssl_certificate_expiration" {
  name                = "ssl-certificate-expiration-alert"
  resource_group_name = data.azurerm_resource_group.apprg.name
  scopes              = [azurerm_application_insights.ssl_monitor.id]
  description         = "Triggers an alert when the SSL certificate is about to expire."

  criteria {
    metric_name        = "my-custom-metric"
    metric_namespace   = "Microsoft.Insights/components"
    aggregation        = "Total"
    operator           = "GreaterThan"
    threshold          = 30
  }
  action {
    action_group_id = azurerm_monitor_action_group.action.id
  }
}*/