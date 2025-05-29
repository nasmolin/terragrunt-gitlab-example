output "generated_memberships" {
  description = "Map of generated memberships"
  sensitive   = false
  value = {
    for user, cfg in var.generate_memberships :
    user_email => {
      user_id        = cfg.user_id
      access_level   = cfg.access_level
    }
  }
}