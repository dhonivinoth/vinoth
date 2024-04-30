module "webapp" {
  source                     = "../module"
  subscription_name          = var.SUBSCRIPTION_NAME
  rg_location                = var.RG_LOCATION
  subscription_id            = var.SUBSCRIPTION_ID
  app_service_plan_name      = var.APP_SERVICE_PLAN_NAME
  app_service_plan_rg_name   = var.APP_SERVICE_PLAN_RG_NAME
  service_plan_id            = var.SERVICE_PLAN_ID
  app_service_name           = var.APP_SERVICE_NAME
  app_service_rg_name        = var.APP_SERVICE_RG_NAME
  app_service_location       = var.APP_SERVICE_LOCATION
  #custom_metric_namespace    = var.CUSTOM_METRIC_NAMESPACE
}
