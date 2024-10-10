data "azurerm_resoruce_group" "rg" {
  name = "rg-myresourcegroup-dev-usnc"
}

data "azurerm_client_config" "current" {}

data "azuread_service_principal" "terraform" {
  display_name = "Terraform-Catalog-Dev"
}

module "example" {
  source  = "TaleLearnCode/servicebus_namespace/azurerm"
  version = "0.0.1-pre"
  providers = {
    azurerm = azurerm
  }

  srv_comp_abbr       = var.srv_comp_abbr_standard
  location            = var.location
  environment         = var.environment
  resource_group_name = data.azurerm_resoruce_group.rg.name
  sku                 = "Standard"
  depends_on = [ data.azurerm_resoruce_group.rg ]
}