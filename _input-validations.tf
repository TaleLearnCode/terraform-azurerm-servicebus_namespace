# #############################################################################
# Input validations
# #############################################################################

# -----------------------------------------------------------------------------
# capacity validations
# -----------------------------------------------------------------------------

locals {
  valid_capacity = var.sku != "Premium" ? var.capacity == 0 : contains([1, 2, 3, 4], var.capacity)
}

resource "null_resource" "validate_capacity" {
  count = local.valid_capacity ? 0 : 1

  provisioner "local-exec" {
    command = "echo 'Invalid capacity value for the selected SKU'"
  }
}

# -----------------------------------------------------------------------------
# premium_messaging_partitions validations
# -----------------------------------------------------------------------------

locals {
  valid_premium_messaging_partions = var.sku != "Premium" ? var.premium_messaging_partions == 0 : contains([1, 2, 3, 4], var.premium_messaging_partions)
}

resource "null_resource" "validate_premium_messaging_partions" {
  count = local.valid_premium_messaging_partions ? 0 : 1

  provisioner "local-exec" {
    command = "echo 'Invalid premium_messaging_partions value for the selected SKU'"
  }
}

# -----------------------------------------------------------------------------
# connection_string_secret_name validations
# -----------------------------------------------------------------------------

locals {
  connection_string_secret_name_valid = var.create_connection_string_secret ? var.connection_string_secret_name != "null" : true
}

resource "null_resource" "validate_connection_string_secret_name" {
  count = local.connection_string_secret_name_valid ? 0 : 1

  provisioner "local-exec" {
    command = "echo 'If create_connection_string_secret is true, connection_string_secret_name must be a value other than null.' && exit 1"
  }
}

# -----------------------------------------------------------------------------
# key_vault_id validations
# -----------------------------------------------------------------------------

locals {
  key_vault_id_valid = var.create_connection_string_secret ? var.key_vault_id != "null" : true
}

resource "null_resource" "validate_key_vault_id" {
  count = local.key_vault_id_valid ? 0 : 1

  provisioner "local-exec" {
    command = "echo 'If create_connection_string_secret is true, key_vault_id must be a value other than null.' && exit 1"
  }
}