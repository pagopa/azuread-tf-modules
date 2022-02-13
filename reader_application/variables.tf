variable "application_name" {
  type        = string
  description = "(Required) App registration unique name."
}

variable "secret_description" {
  type        = string
  description = "(Required) Description of the app's secret."
}

variable "accessible_subscriptions" {
  type        = list(string)
  description = "(Required) The subscriptions ids that the application can read."
}
