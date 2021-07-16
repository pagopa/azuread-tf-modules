variable "name" {
  type        = string
  description = "(Required) Azure VPN application name"
}

variable "azure_vpn_application_id" {
  type        = string
  description = "(Optional) Azure VPN client application id (static)"
  default     = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
}
