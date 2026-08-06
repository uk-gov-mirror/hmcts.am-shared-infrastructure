module "vault" {
  source                               = "git@github.com:hmcts/cnp-module-key-vault?ref=DTSPO-31965/remove-jenkins-ptl-access"
  name                                 = join("-", [var.product, var.env])
  product                              = join("-", [var.product, "shared"])
  env                                  = var.env
  tenant_id                            = var.tenant_id
  object_id                            = var.jenkins_AAD_objectId
  jenkins_object_id                    = data.azurerm_user_assigned_identity.jenkins.principal_id
  resource_group_name                  = azurerm_resource_group.rg.name
  product_group_object_id              = var.product_group_object_id
  create_managed_identity              = true
  common_tags                          = local.tags
  additional_managed_identities_access = var.additional_managed_identities_access

  grant_preview_jenkins_access = var.env == "aat"
}

resource "azurerm_key_vault_secret" "appInsightsInstrumentationKey" {
  name         = "AppInsightsInstrumentationKey"
  value        = module.application_insights.instrumentation_key
  key_vault_id = module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "app_insights_connection_string" {
  name         = "app-insights-connection-string"
  value        = module.application_insights.connection_string
  key_vault_id = module.vault.key_vault_id
}

data "azurerm_servicebus_topic_authorization_rule" "rd-caseworker-topic-auth-rule" {
  name                = "SendAndListenSharedAccessKey"
  resource_group_name = join("-", ["rd", var.env])
  namespace_name      = join("-", ["rd", "servicebus", var.env])
  topic_name          = join("-", ["rd", "caseworker-topic", var.env])
}

resource "azurerm_key_vault_secret" "caseworker-topic-primary-send-listen-shared-access-key" {
  name         = "caseworker-topic-primary-send-listen-shared-access-key"
  value        = data.azurerm_servicebus_topic_authorization_rule.rd-caseworker-topic-auth-rule.primary_key
  key_vault_id = module.vault.key_vault_id
}

data "azurerm_servicebus_topic_authorization_rule" "rd-judicial-topic-auth-rule" {
  name                = "SendAndListenSharedAccessKey"
  resource_group_name = join("-", ["rd", var.env])
  namespace_name      = join("-", ["rd", "servicebus", var.env])
  topic_name          = join("-", ["rd", "judicial-topic", var.env])
}
resource "azurerm_key_vault_secret" "judicial-topic-primary-send-listen-shared-access-key" {
  name         = "judicial-topic-primary-send-listen-shared-access-key"
  value        = data.azurerm_servicebus_topic_authorization_rule.rd-judicial-topic-auth-rule.primary_key
  key_vault_id = module.vault.key_vault_id
}
