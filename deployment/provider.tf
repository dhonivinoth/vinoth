
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "firstrg701"
    storage_account_name = "firststg702"
    container_name       = "devopscontainer"
    key                  = "alert.terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
}