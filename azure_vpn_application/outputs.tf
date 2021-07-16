output "azuread_application_id" {
  value = azuread_application.this.id
}

output "azuread_application_application_id" {
  value = azuread_application.this.application_id
}

output "azuread_application_object_id" {
  value = azuread_application.this.object_id
}

output "azuread_service_principal_object_id" {
  value = azuread_service_principal.this.object_id
}
