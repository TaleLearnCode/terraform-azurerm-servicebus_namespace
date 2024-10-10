# Azure App Configuration Terraform Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md)

This module manages Azure Service Bus namespaces using the [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) Terraform provider.

## Providers

| Name    | Version |
| ------- | ------- |
| azurerm | ~> 4.1. |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| Regions | TaleLearnCode/regions/azurerm | ~> .0.0.1-pre |

## Resources

No resources.

## Usage

```hcl
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

For more detailed instructions on using this module: please refer to the appropriate example:

- [Default](examples/default/README.md)

## Inputs

| Name            | Description                                                  | Type   | Default | Required |
| ----------------------------- | ------------------------------------------------------------ | ------- | -------------- | -------- |
| capacity                        | The capacity of the Service Bus namespace. This is only applicable when the `Premium` SKU is selected. | number       | 0              | no       |
| connection_string_secret_name   | The name of the secret to create in the Azure Key Vault.     | string       | null           | no       |
| create_connection_string_secret | Should a connection string secret be created in the Azure Key Vault? | bool         | false          | no       |
| current_user_object_id          | The object identifier of the current user.                   | string       | N/A            | yes      |
| custom_name                     | If set, the custom name to use instead of the generated name. | string       | NULL           | no       |
| environment                     | The environment where the resources are deployed to. Valid values are `dev`, `qa`, `e2e`, and `prod`. | string       | N/A            | yes      |
| identity_ids                    | A list of User Assigned Managed Service Identity Ids to assign to the Service Bus namespace. | list(string) | []             | no       |
| identity_type                   | The type of Managed Service Identity to assign to the Service Bus namespace. Options are `SystemAssigned`, `UserAssigned`, and `SystemAssigned, UserAssigned` (to enable both). | string       | SystemAssigned | no       |
| key_vault_id                    | The identifier of the Azure Key Vault in which to create the secret. This is required if `create_connection_string_secret` is set to true. | string       | null           | no       |
| local_auth_enabled              | Whether or no SAS authentication is enabled for the Service Bus namespace. | bool         | true           | no       |
| location                        | The Azure Region in which all resources will be created      | string       | N/A            | yes      |
| premium_messaging_partitions    | The number of messaging partitions to use. This is only applicable when the `Premium` SKU is select. | number       | 0              | no       |
| public_network_access_enabled   | Should the Service Bus namespace be accessible from public networks. | bool         | true           | no       |
| name_prefix                     | Optional prefix to apply to the generated name.              | string       | ""             | no       |
| name_suffix                     | Optional suffix to apply to the generated name.              | string       | ""             | no       |
| resource_group_name             | The name of the Resource Group in which the Service Bus namespace should be created. | string       | N/A            | yes      |
| service_principal_object_id     | The object identifier of the service principal.              | string       | N/A            | yes      |
| sku                             | Defines which tier to use. Options are `Basic`, `Standard`, and `Premium`. | string       | Standard       | no       |
| srv_comp_abbr                   | The abbreviation of the service or component for which the resources are being created for. | string       | NULL           | no       |
| tags                            | A map of tags to apply to all resources.                     | map          | N/A            | no       |

## Outputs

| Name                 | Description                              |
| -------------------- | ---------------------------------------- |
| servicebus_namespace | The managed Azure Service Bus namespace. |

# Naming Guidelines

### App Configuration

| Guideline                       |                                         |
| ------------------------------- | ------------------------------------------------------------ |
| Resource Type Identifier        | appcs                                                        |
| Scope                           | Global                                                       |
| Max Overall Length              | 6 - 50 characters                                            |
| Allowed Component Name Length * | 30 characters                                                |
| Valid Characters                | Alphanumerics and hyphens. Start with letter. End with alphanumeric. |
| Regex                           | `^[a-zA-Z][a-zA-Z0-9-]{4,48}[a-zA-Z0-9]$`                    |

* Allowed Component Name Length is a combination of the `srv_comp_abbr`, `name_prefix`, and `name_suffix` or the `custom_name` if used.