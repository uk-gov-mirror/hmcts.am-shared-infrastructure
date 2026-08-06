provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "sendgrid"
  subscription_id = var.env != "prod" ? local.sendgrid_subscription.nonprod : local.sendgrid_subscription.prod
  features {}
}

terraform {

  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0" # AzureRM provider version
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "2.47.0"
    }
  }
}
