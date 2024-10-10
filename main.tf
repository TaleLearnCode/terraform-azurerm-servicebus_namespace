# #############################################################################
# Terraform Module: App Configuration Store
# #############################################################################

module "naming" {
  source  = "TaleLearnCode/naming/azurerm"
  version = "0.0.2-pre"

  resource_type  = "servicebus_namespace"
  name_prefix    = var.name_prefix
  name_suffix    = var.name_suffix
  srv_comp_abbr  = var.srv_comp_abbr
  custom_name    = var.custom_name
  location       = var.location
  environment    = var.environment
}


resource "azurerm_servicebus_namespace" "target" {
  name                = module.naming.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  capacity                     = var.sku != "Premium" ? 0 : var.capacity
  premium_messaging_partitions = var.sku != "Premium" ? 0 : var.premium_messaging_partions
  local_auth_enabled           = var.local_auth_enabled
  minimum_tls_version          = "1.2"
  public_network_access_enabled = var.public_network_access_enabled
  dynamic "identity" {
    for_each = var.identity_type == null ? [] : ["enabled"]
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids == "UserAssigned" ? var.identity_ids : null
    }
  }
}

data "azurerm_servicebus_namespace_authorization_rule" "root_managed_shared_access_key" {
  name         = "RootManageSharedAccessKey"
  namespace_id = azurerm_servicebus_namespace.target.id
  depends_on   = [azurerm_servicebus_namespace.target]
}

resource "azurerm_key_vault_secret" "service_bus" {
  count        = var.create_connection_string_secret ? 1 : 0
  name         = var.connection_string_secret_name
  value        = data.azurerm_servicebus_namespace_authorization_rule.root_managed_shared_access_key.primary_connection_string
  key_vault_id = var.key_vault_id
}