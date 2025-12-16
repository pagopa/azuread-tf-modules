variable "name" {
  type        = string
  description = "(Required) Azure VPN application name"
}

variable "azure_vpn_application_id" {
  type        = string
  description = "(Optional) Azure VPN client application id (static)"
  default     = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
}

# This variable is used to handle the "InvalidUniqueTenantIdentifierAsPerAppPolicy" error.
# New Azure AD policies require the Identifier URI to contain a verified domain, tenant ID, or app ID.
# Set this to `false` for new applications to use the compliant format: api://<tenant_id>/<name>
# Keep it `true` for existing applications to avoid breaking changes (api://<name>).
variable "legacy" {
  type        = bool
  description = "(Optional) If true, use the legacy identifier URI format (api://<name>). If false, use the new format (api://<tenant_id>/<name>)."
  default     = true
}
