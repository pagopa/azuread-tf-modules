output "client_id" {
  value       = azuread_application.this.application_id
  description = "The client id of the registration."
}

output "client_secret" {
  value       = azuread_application_password.this.value
  description = "The client secret of the registration."
  sensitive   = true
}
