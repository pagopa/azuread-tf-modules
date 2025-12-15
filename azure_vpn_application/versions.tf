terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.7"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }

  required_version = ">= 1.10.0"
}
