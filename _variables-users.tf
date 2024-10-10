# #############################################################################
# Variables for the users that will be granted access to the key vault
# #############################################################################

variable "app_configuration_data_owners" {
  type    = list(string)
  default = []
  description = "A list of user principal IDs that will be granted access to the key vault as App Configuration Data Owner."
}