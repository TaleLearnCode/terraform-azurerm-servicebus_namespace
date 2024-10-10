# #############################################################################
# Variables: Service Bus Namespace
# #############################################################################

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which the Service Bus Namespace should be created."
}

variable "sku" {
  type        = string
  description = "Defines which tier to use. Options are 'Basic', 'Standard', and 'Premium'. The default is 'Standard'."
  default     = "Standard"
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The type must be either 'Basic', 'Standard' or 'Premium'."
  }
}

variable "identity_type" {
  type        = string
  description = "The type of Managed Service Identity to assign to the Service Bus Namespace. Options are 'SystemAssigned', 'UserAssigned', and 'SystemAssigned, UserAssigned' (to enable both). The default is 'SystemAssigned'."
  default     = "SystemAssigned"
  validation {
    condition = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type)
    error_message = "The type must be either 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'."
  }
}

variable "identity_ids" {
  type        = list(string)
  description = "A list of User Assigned Managed Service Identity IDs to assign to the Service Bus Namespace."
  default     = []
}

variable "capacity" {
  type        = number
  description = "The capacity of the Service Bus Namespace. This is only applicable when the 'Premium' SKU is selected."
  default     = 0
  validation {
    condition     = var.capacity == 0 || contains([1, 2, 3, 4], var.capacity)
    error_message = "If sku is not 'Premium', capacity must be 0. If sku is 'Premium', capacity must be one of 1, 2, 3, or 4."
  }
}

variable "premium_messaging_partions" {
  type        = number
  description = "The number of messaging partitions to use. This is only applicable when the 'Premium' SKU is selected."
  default     = 0
  validation {
    condition     = var.premium_messaging_partions == 0 || contains([1, 2, 3, 4], var.premium_messaging_partions)
    error_message = "If sku is not 'Premium', premium_messaging_partions must be 0. If sku is 'Premium', premium_messaging_partions must be one of 1, 2, 3, or 4."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Should the Service Bus Namespace be accessible from public networks? Defaults to true."
  default     = true
}

variable "local_auth_enabled" {
  type        = bool
  description = "Whether or not SAS authentication is enabled for the Service Bus namespace. Defaults to true."
  default     = true
}

variable "create_connection_string_secret" {
  type        = bool
  description = "Should a connection string secret be created in the Azure Key Vault? Defaults to false."
  default     = false
}

variable "connection_string_secret_name" {
  type        = string
  description = "The name of the secret to create in the Azure Key Vault. Defaults to 'service-bus-connection-string'."
  default     = "null"
}

variable "key_vault_id" {
  type        = string
  description = "The ID of the Azure Key Vault in which to create the secret. This is required if 'create_connection_string_secret' is set to true."
  default     = "null"
}