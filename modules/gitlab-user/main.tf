resource "random_password" "user" {
  for_each = var.users

  length  = 16
  special = true
}

resource "gitlab_user" "this" {
  for_each = var.users

  name              = each.value.name
  username          = each.value.username
  email             = each.value.email
  state             = each.value.state
  is_admin          = false
  can_create_group  = false
  projects_limit    = 0
  skip_confirmation = true
  is_external       = false
  reset_password    = false
  password          = random_password.user[each.key].result
  note              = "Created by Terraform"
}