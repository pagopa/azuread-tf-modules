data "azuread_client_config" "current" {}

locals {
  # This variable is used to handle the "InvalidUniqueTenantIdentifierAsPerAppPolicy" error.
  # New Azure AD policies require the Identifier URI to contain a verified domain, tenant ID, or app ID.
  # Set this to `false` for new applications to use the compliant format: api://<tenant_id>/<name>
  # Keep it `true` for existing applications to avoid breaking changes (api://<name>).
  identifier_uri = var.legacy ? "api://${var.name}" : "api://${data.azuread_client_config.current.tenant_id}/${var.name}"
}

resource "random_uuid" "oauth2_permission_scope_id" {}

resource "azuread_application" "this" {
  display_name            = var.name
  prevent_duplicate_names = true
  identifier_uris         = [local.identifier_uri]
  sign_in_audience        = "AzureADMyOrg"

  api {
    known_client_applications = [var.azure_vpn_application_id]

    oauth2_permission_scope {
      admin_consent_description  = var.name
      admin_consent_display_name = var.name
      id                         = random_uuid.oauth2_permission_scope_id.result
      enabled                    = true
      type                       = "Admin"
      value                      = var.name
    }
  }

  web {
    redirect_uris = []
    implicit_grant {
      access_token_issuance_enabled = false
    }
  }

  required_resource_access {
    # Microsoft Graph
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      # User.Read
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }
  }
}

resource "azuread_service_principal" "this" {
  client_id                    = azuread_application.this.client_id
  app_role_assignment_required = true

  tags = ["HideApp", "WindowsAzureActiveDirectoryIntegratedApp"]
}

resource "azuread_application_pre_authorized" "this" {
  count                = var.legacy ? 0 : 1
  application_id       = azuread_application.this.object_id
  authorized_client_id = var.azure_vpn_application_id
  permission_ids       = [random_uuid.oauth2_permission_scope_id.result]
}

moved {
  from = null_resource.this
  to   = null_resource.this[0]
}

moved {
  from = time_sleep.wait
  to   = time_sleep.wait[0]
}

resource "time_sleep" "wait" {
  count           = var.legacy ? 1 : 0
  create_duration = "60s"
}

resource "null_resource" "this" {
  count = var.legacy ? 1 : 0
  # needs az cli > 2.0.81
  # see https://github.com/Azure/azure-cli/issues/12152
  depends_on = [azuread_application.this, time_sleep.wait]
  # https://github.com/Azure/azure-cli/issues/9522#issuecomment-603628528
  provisioner "local-exec" {
    command = <<EOT
      az rest \
        --method PATCH \
        --uri https://graph.microsoft.com/beta/applications/${azuread_application.this.object_id} \
        --body "{\"api\":{\"preAuthorizedApplications\":[{\"appId\":\"${var.azure_vpn_application_id}\",\"permissionIds\":[\"${random_uuid.oauth2_permission_scope_id.result}\"]}]}}" \
        --headers "Content-Type=application/json"
    EOT
  }
}
