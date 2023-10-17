terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "=3.2.1"
    }
  }
}

resource "null_resource" "this" {
  triggers = {
    service_principal_object_id = var.service_principal_object_id
    user_object_id              = var.user_object_id
  }

  # https://docs.microsoft.com/en-us/graph/api/serviceprincipal-post-approleassignedto?view=graph-rest-1.0&tabs=http
  provisioner "local-exec" {
    command = <<EOT
      az rest \
        --method POST \
        --uri https://graph.microsoft.com/v1.0/servicePrincipals/${self.triggers.service_principal_object_id}/appRoleAssignedTo \
        --body "{\"principalId\": \"${self.triggers.user_object_id}\",\"resourceId\": \"${self.triggers.service_principal_object_id}\"}" \
        --headers "Content-Type=application/json"
    EOT
  }

  # https://docs.microsoft.com/en-us/graph/api/serviceprincipal-delete-approleassignedto?view=graph-rest-1.0&tabs=http
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      id=$(az rest --method GET \
        --uri https://graph.microsoft.com/v1.0/servicePrincipals/${self.triggers.service_principal_object_id}/appRoleAssignedTo \
        -o tsv --query "value[?contains(principalId,'${self.triggers.user_object_id}')].{Name:id}")
      az rest --method DELETE \
        --uri https://graph.microsoft.com/v1.0/servicePrincipals/${self.triggers.service_principal_object_id}/appRoleAssignedTo/$id
    EOT
  }
}
