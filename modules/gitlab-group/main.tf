resource "gitlab_group" "this" {
  name                                = var.name
  path                                = var.path
  parent_id                           = var.parent_id
  description                         = var.description

  visibility_level                    = var.visibility
  auto_devops_enabled                 = var.auto_devops_enabled
  extra_shared_runners_minutes_limit  = var.extra_shared_runners_minutes_limit
  lfs_enabled                         = var.lfs_enabled
  mentions_disabled                   = var.mentions_disabled
  prevent_forking_outside_group       = var.prevent_forking_outside_group
  project_creation_level              = var.project_creation_level
  request_access_enabled              = var.request_access_enabled
  share_with_group_lock               = var.share_with_group_lock
  shared_runners_minutes_limit        = var.shared_runners_minutes_limit
  subgroup_creation_level             = var.subgroup_creation_level
  two_factor_grace_period             = var.two_factor_grace_period
}

resource "gitlab_group_variable" "this" {
  for_each          = var.group_variables

  group             = gitlab_group.this.id
  key               = each.key
  value             = each.value.value
  protected         = try(each.value.protected, false)
  masked            = try(each.value.masked, false)
  environment_scope = "*"
}

resource "gitlab_group_membership" "this" {
  for_each = var.memberships

  user_id     = each.value.user_id
  group_id    = gitlab_group.this.id
  access_level = each.value.access_level
}
