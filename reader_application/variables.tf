variable "application_name" {
  type        = string
  description = "(Required) App registration unique name."
}

variable "secret_description" {
  type        = string
  description = "(Required) Description of the app's secret."
}

variable "subscription_id" {
  type        = string
  description = "(Required) Subscription of the `default-roleassignment-rg` resouce group."
}
