module "application_insights" {
  source   = "git@github.com:hmcts/terraform-module-application-insights?ref=4.x"
  location = var.appinsights_location
  env      = var.env
  product  = var.product
  sampling_percentage = var.sampling_percentage
  resource_group_name = azurerm_resource_group.rg.name
  common_tags = local.tags
}

moved {
  from = azurerm_application_insights.appinsights
  to   = module.application_insights.azurerm_application_insights.this
}
