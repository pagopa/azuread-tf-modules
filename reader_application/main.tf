terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.96.0"
    }
  }
}

resource "azuread_application" "this" {
  display_name            = var.application_name
  prevent_duplicate_names = true
}

resource "azuread_application_password" "this" {
  application_object_id = azuread_application.this.object_id
  description           = var.secret_description
}

resource "azuread_service_principal" "this" {
  application_id = azuread_application.this.application_id
}

resource "azurerm_role_assignment" "this" {
  principal_id         = azuread_service_principal.this.id
  role_definition_name = "Reader"
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/default-roleassignment-rg"
}
