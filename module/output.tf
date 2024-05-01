output "cpu_alert_id" {
  value = azurerm_monitor_metric_alert.cpu_alert.id
}

output "memory_alert_id" {
  value = azurerm_monitor_metric_alert.memory_alert.id
}

output "response_time_alert_id" {
  value = azurerm_monitor_metric_alert.response_time_alert.id
}
