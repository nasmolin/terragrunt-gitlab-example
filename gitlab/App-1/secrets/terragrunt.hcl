terraform {
  source = "../../../modules/secrets-generator"
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  generate_secrets = {
    JWT_SECRET = {
      secret_key            = "JWT_SECRET"
      secret_description    = "Managed by Terraform. Web server JWT token."
      secret_length         = 12
      secret_special        = false
      secret_protected      = true
      secret_masked         = true
    }
    DEV_DATABASE_PASSWORD = {
      secret_key            = "DEV_DATABASE_PASSWORD"
      secret_description    = "Managed by Terraform. PostgresQL dev db connection password."
      secret_length         = 12
      secret_special        = false
      secret_protected      = true
      secret_masked         = true
    }
  }
}
