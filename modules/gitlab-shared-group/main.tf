resource "gitlab_group" "this" {
  name                                = var.name
  path                                = var.path
  parent_id                           = var.parent_id
  description                         = var.description
}

resource "gitlab_group_membership" "this" {
  for_each = var.memberships

  user_id     = each.value.user_id
  group_id    = gitlab_group.this.id
  access_level = each.value.access_level
}