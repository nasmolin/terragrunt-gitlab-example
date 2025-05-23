resource "gitlab_project" "this" {
  name                                         = var.name
  path                                         = var.path
  namespace_id                                 = var.namespace_id
  description                                  = var.description
  visibility_level                             = var.visibility_level
  default_branch                               = var.default_branch
  archived                                     = var.archived
  avatar                                       = var.avatar
  issues_enabled                               = var.issues_enabled
  merge_requests_enabled                       = var.merge_requests_enabled
  wiki_enabled                                 = var.wiki_enabled
  snippets_enabled                             = var.snippets_enabled
  lfs_enabled                                  = var.lfs_enabled
  request_access_enabled                       = var.request_access_enabled
  only_allow_merge_if_pipeline_succeeds        = var.only_allow_merge_if_pipeline_succeeds
  only_allow_merge_if_all_discussions_are_resolved = var.only_allow_merge_if_all_discussions_are_resolved
  initialize_with_readme                       = var.initialize_with_readme
  build_timeout                                = var.build_timeout
  ci_config_path                               = var.ci_config_path
  ci_default_git_depth                         = var.ci_default_git_depth
  auto_cancel_pending_pipelines                = var.auto_cancel_pending_pipelines
  auto_devops_enabled                          = var.auto_devops_enabled
  auto_devops_deploy_strategy                  = var.auto_devops_deploy_strategy
  build_git_strategy                           = var.build_git_strategy
  ci_forward_deployment_enabled                = var.ci_forward_deployment_enabled
  ci_pipeline_variables_minimum_override_role  = var.ci_pipeline_variables_minimum_override_role
  ci_separated_caches                          = var.ci_separated_caches
  merge_method                                 = var.merge_method
  group_runners_enabled                        = var.group_runners_enabled
  allow_merge_on_skipped_pipeline              = var.allow_merge_on_skipped_pipeline
  allow_pipeline_trigger_approve_deployment    = var.allow_pipeline_trigger_approve_deployment
  archive_on_destroy                           = var.archive_on_destroy
  autoclose_referenced_issues                  = var.autoclose_referenced_issues
  avatar_hash                                  = var.avatar_hash
  ci_delete_pipelines_in_seconds               = var.ci_delete_pipelines_in_seconds
  forking_access_level                         = var.forking_access_level
  group_with_project_templates_id              = var.group_with_project_templates_id
  model_experiments_access_level               = var.model_experiments_access_level
  model_registry_access_level                  = var.model_registry_access_level
  monitor_access_level                         = var.monitor_access_level
  packages_enabled                             = var.packages_enabled
  pages_access_level                           = var.pages_access_level
  printing_merge_request_link_enabled          = var.printing_merge_request_link_enabled
  analytics_access_level                       = var.analytics_access_level
  builds_access_level                          = var.builds_access_level
  environments_access_level                    = var.environments_access_level
  feature_flags_access_level                   = var.feature_flags_access_level
  infrastructure_access_level                  = var.infrastructure_access_level
  issues_access_level                          = var.issues_access_level
  merge_requests_access_level                  = var.merge_requests_access_level
  squash_option                                = var.squash_option

  container_expiration_policy {
    cadence            = var.container_expiration_policy[0].cadence
    enabled            = var.container_expiration_policy[0].enabled
    keep_n             = var.container_expiration_policy[0].keep_n
    name_regex_delete  = var.container_expiration_policy[0].name_regex_delete
    name_regex_keep    = var.container_expiration_policy[0].name_regex_keep
    older_than         = var.container_expiration_policy[0].older_than
  }
  merge_commit_template = var.merge_commit_template
}

resource "gitlab_branch_protection" "default_branch" {
  project                = gitlab_project.this.id
  branch                 = var.default_branch
  push_access_level      = "developer"
  merge_access_level     = "developer"
  unprotect_access_level = "admin"
}

resource "gitlab_branch" "extra_branches" {
  for_each = toset(var.extra_branches)

  name    = each.value
  ref     = var.default_branch
  project = gitlab_project.this.id
}

resource "gitlab_branch_protection" "extra_branches" {
  for_each = toset(var.extra_branches)

  project                = gitlab_project.this.id
  branch                 = each.value
  push_access_level      = "no one"
  merge_access_level     = "maintainer"
  unprotect_access_level = "admin"
}

resource "gitlab_tag_protection" "tags" {
  for_each = toset(var.protected_tags)

  project              = gitlab_project.this.id
  tag                  = each.value
  create_access_level  = "maintainer"
}
