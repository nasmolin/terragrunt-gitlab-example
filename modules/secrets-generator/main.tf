terraform {
  backend "local" {}

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

resource "random_password" "generated" {
  for_each = var.generate_secrets

  length  = each.value.secret_length
  special = each.value.secret_special
}


