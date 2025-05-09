variable "generate_secrets" {
  description = "Map of secrets to generate"
  type = map(object({
    secret_key          = string
    secret_length       = optional(number, 16)
    secret_description  = optional(string, "Managed by Terraform.")
    secret_special      = optional(bool, true)
    secret_protected    = optional(bool, true)
    secret_masked       = optional(bool, true)
  }))
}