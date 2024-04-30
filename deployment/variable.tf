variable "SUBSCRIPTION_NAME" {
  type        = string
  description = "Name Of The Subscription"
  default     = null
}

variable "RG_LOCATION" {
  type        = string
  description = "Location of the resource group"
  default     = "westeurope"
}

variable "SUBSCRIPTION_ID" {
  type        = string
  description = "Azure Subscription ID"
  default     = null
}

variable "APP_SERVICE_PLAN_NAME" {
  type        = string
  description = "Name of the app service plan"
  default     = null
}

variable "APP_SERVICE_PLAN_RG_NAME" {
  type        = string
  default     = null
  description = "Name of the resource group where the app service plan exists."
}

variable "SERVICE_PLAN_ID" {
  type        = string
  default     = null
  description = "Name of the the app service plan id."
}

variable "APP_SERVICE_NAME" {
  type        = string
  description = "The name of the webapp"
  default     = null
}

variable "APP_SERVICE_RG_NAME" {
  type        = string
  default     = null
  description = "Name of the resource group where the app service exists."
}

variable "APP_SERVICE_LOCATION" {
  type        = string
  default     = "westeurope"
  description = "The location of the app service being created."
}

/*variable "CUSTOM_METRIC_NAMESPACE" {
  type        = string
  default     = null
  description = "Namespace for custom metrics in Azure Monitor"
}*/