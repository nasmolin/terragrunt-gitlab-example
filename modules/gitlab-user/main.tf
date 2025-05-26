resource "random_password" "user" {
  for_each = {
    for username, user in var.users : username => user
    if user.create_user
  }

  length  = 16
  special = true
}

resource "gitlab_user" "created" {
  for_each = {
    for username, user in var.users : username => user
    if user.create_user
  }

  name                   = each.value.name
  username               = each.value.username
  email                  = each.value.email
  state                  = each.value.state
  is_admin               = each.value.is_admin
  can_create_group       = false
  projects_limit         = 0
  skip_confirmation      = true
  is_external            = false
  password               = random_password.user[each.key].result
  note                   = "Created by Terraform"
}

resource "gitlab_user" "imported" {
  for_each = {
    for username, user in var.users : username => user
    if !user.create_user
  }

  name              = each.value.name
  username          = each.value.username
  email             = each.value.email
  state             = each.value.state
  is_admin          = each.value.is_admin
  can_create_group  = false
  projects_limit    = 0
  skip_confirmation = true
  is_external       = false
  note              = "Imported by Terraform"
}