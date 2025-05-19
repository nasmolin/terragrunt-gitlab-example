locals {
  all_members = merge(
    { for email in var.developers  : email => "developer" },
    { for email in var.maintainers : email => "maintainer" },
    { for email in var.owners      : email => "owner" }
  )

  memberships = {
    for email, role in local.all_members :
    email => {
      access_level = role
      user_id      = var.user_ids_map[email]
    }
  }
}

output "generated_memberships" {
  value = local.memberships
}
