
terraform {
  backend "local" {}
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "= 17.11.0"
    }
  }
}



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
  ci_restrict_pipeline_cancellation_role       = var.ci_restrict_pipeline_cancellation_role
  ci_separated_caches                          = var.ci_separated_caches
  merge_method                                 = var.merge_method
  merge_pipelines_enabled                      = var.merge_pipelines_enabled
  merge_trains_enabled                         = var.merge_trains_enabled
  group_runners_enabled                        = var.group_runners_enabled
  allow_merge_on_skipped_pipeline              = var.allow_merge_on_skipped_pipeline
  allow_pipeline_trigger_approve_deployment    = var.allow_pipeline_trigger_approve_deployment
  archive_on_destroy                           = var.archive_on_destroy
  autoclose_referenced_issues                  = var.autoclose_referenced_issues
  avatar_hash                                  = var.avatar_hash
  ci_delete_pipelines_in_seconds               = var.ci_delete_pipelines_in_seconds
  external_authorization_classification_label  = var.external_authorization_classification_label
  forking_access_level                         = var.forking_access_level
  group_with_project_templates_id              = var.group_with_project_templates_id
  model_experiments_access_level               = var.model_experiments_access_level
  model_registry_access_level                  = var.model_registry_access_level
  monitor_access_level                         = var.monitor_access_level
  packages_enabled                             = var.packages_enabled
  pages_access_level                           = var.pages_access_level
  pre_receive_secret_detection_enabled         = var.pre_receive_secret_detection_enabled
  prevent_merge_without_jira_issue             = var.prevent_merge_without_jira_issue
  printing_merge_request_link_enabled          = var.printing_merge_request_link_enabled
  analytics_access_level                       = var.analytics_access_level
  builds_access_level                          = var.builds_access_level
  environments_access_level                    = var.environments_access_level
  feature_flags_access_level                   = var.feature_flags_access_level
  infrastructure_access_level                  = var.infrastructure_access_level
  issues_access_level                          = var.issues_access_level
  merge_requests_access_level                  = var.merge_requests_access_level

#  отключено до обновления gitlab и проверки.
#  push_rules {
#    author_email_regex            = var.push_rules[0].author_email_regex
#    branch_name_regex             = var.push_rules[0].branch_name_regex
#    commit_committer_check        = var.push_rules[0].commit_committer_check
#    commit_committer_name_check   = var.push_rules[0].commit_committer_name_check
#    commit_message_negative_regex = var.push_rules[0].commit_message_negative_regex
#    commit_message_regex          = var.push_rules[0].commit_message_regex
#    deny_delete_tag               = var.push_rules[0].deny_delete_tag
#    file_name_regex               = var.push_rules[0].file_name_regex
#    max_file_size                 = var.push_rules[0].max_file_size
#    member_check                  = var.push_rules[0].member_check
#    prevent_secrets               = var.push_rules[0].prevent_secrets
#    reject_non_dco_commits        = var.push_rules[0].reject_non_dco_commits
#    reject_unsigned_commits       = var.push_rules[0].reject_unsigned_commits
#  }

  container_expiration_policy {
    cadence            = var.container_expiration_policy[0].cadence
    enabled            = var.container_expiration_policy[0].enabled
    keep_n             = var.container_expiration_policy[0].keep_n
    name_regex_delete  = var.container_expiration_policy[0].name_regex_delete
    name_regex_keep    = var.container_expiration_policy[0].name_regex_keep
    older_than         = var.container_expiration_policy[0].older_than
  }

  merge_commit_template = var.merge_commit_template
  merge_requests_template = var.merge_requests_template
  issues_template = var.issues_template
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

resource "gitlab_project_variable" "vars" {
  for_each = var.variables

  project   = gitlab_project.this.id
  key       = each.key
  value     = each.value.value
  protected = try(each.value.protected, false)
  masked    = try(each.value.masked, false)
}

resource "gitlab_tag_protection" "tags" {
  for_each = toset(var.protected_tags)

  project              = gitlab_project.this.id
  tag                  = each.value
  create_access_level  = "maintainer"
}
