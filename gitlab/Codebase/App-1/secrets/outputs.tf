output "generated_secrets" {
  description = "Map of generated secrets"
  sensitive   = true
  value = {
    for key, cfg in var.generate_secrets :
    key => {
      key            = cfg.secret_key
      value          = random_password.generated[key].result
      description    = cfg.secret_description
      protected      = cfg.secret_protected
      masked         = cfg.secret_masked
    }
  }
}