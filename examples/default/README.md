# Example: Managing an Azure Service Bus Namespace
This module manages an Service Bus namespace using the [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) Terraform provider.  This example shows how to use the module to manage an Azure Service Bus namespace using the **Standard** SKU.

## Example Usage

```hcl
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
```

You are specifying three values:

- **srv_comp_abbr**: The abbreviation for the service/component the Service Bus namespace supports.
- **location**: The Azure Region in which all resources will be created.
- **environment**: The environment where the resources are deployed to.
- **resource_group_name**: The name of the Resource Group in which the Service Bus namespace will be created.
- **sku**: The SKU to use to build the Service Bus namespace.

This will result in an Azure Service Bus namespace named: `sbns-example-dev-usnc`.