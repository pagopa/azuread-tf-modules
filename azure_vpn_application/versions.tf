terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3"
    }
  }
}
