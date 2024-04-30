variable "subscription_name" {
  type        = string
  default     = null
  description = "Name Of The Subscription."
}

variable "rg_name" {
  type        = string
  default     = null
  description = "Name of the resource group."
}

variable "rg_location" {
  type        = string
  default     = null
  description = "Location of the resource group."
}

variable "subscription_id" {
  type        = string
  default     = null
  description = "ID of the subscription."
}

variable "app_service_plan_name" {
  type        = string
  default     = null
  description = "Name of the app service plan."
}

variable "app_service_plan_rg_name" {
  type        = string
  default     = null
  description = "Name of the resource group where the app service plan exists."
}

variable "service_plan_id" {
  type        = string
  default     = null
  description = "Name of the the app service plan id."
}

variable "app_service_name" {
  type        = string
  default     = null
  description = "Name of the app service."
}

variable "app_service_rg_name" {
  type        = string
  default     = null
  description = "Name of the resource group where the app service exists."
}

variable "app_service_location" {
  type        = string
  default     = null
  description = "The location of the app service being created."
}

/*variable "custom_metric_namespace" {
  type        = string
  default     = null
  description = "Namespace for custom metrics in Azure Monitor"
}*/