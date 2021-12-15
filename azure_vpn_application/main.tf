terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "=3.1.0"
    }
  }
}

resource "random_uuid" "oauth2_permission_scope_id" {}

resource "azuread_application" "this" {
  display_name            = var.name
  prevent_duplicate_names = true
  identifier_uris         = [format("api://%s", var.name)]
  sign_in_audience        = "AzureADMyOrg"

  api {
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

resource "time_sleep" "wait" {
  create_duration = "60s"
}

resource "null_resource" "this" {
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

resource "azuread_service_principal" "this" {
  application_id               = azuread_application.this.application_id
  app_role_assignment_required = true

  tags = ["HideApp", "WindowsAzureActiveDirectoryIntegratedApp"]
}
