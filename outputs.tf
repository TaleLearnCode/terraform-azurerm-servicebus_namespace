# #############################################################################
# Outputs
# #############################################################################

output "servicebus_namespace" {
  value       = azurerm_servicebus_namespace.target
  description = "The Service Bus Namespace."
}