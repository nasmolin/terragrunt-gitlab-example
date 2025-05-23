
# ====================================
# resource gitlab_tag_protection variables
# ====================================

variable "protected_tags" {
  type        = list(string)
  description = "List of tag names to be protected in the GitLab project."
  default     = ["v*", "release-*"]
}

# ====================================
# resource gitlab_branch variables
# ====================================

variable "extra_branches" {
  description = "List of additional branches to create in the GitLab project and protect"
  type        = list(string)
  default     = ["staging", "production"]
}

# ====================================
# resource gitlab_project variables
# ====================================

variable "name" {
  description = "The name of the project"
  type        = string
}

variable "allow_merge_on_skipped_pipeline" {
  description = "Treat skipped pipelines as if they finished with success"
  type        = bool
  default     = false
}

variable "allow_pipeline_trigger_approve_deployment" {
  description = "Pipeline triggerer can approve deployments"
  type        = bool
  default     = false
}

variable "analytics_access_level" {
  description = "Analytics access level"
  type        = string
  default     = "disabled"
}

variable "archive_on_destroy" {
  description = "Archive project instead of deleting on destroy"
  type        = bool
  default     = true
}

variable "archived" {
  description = "Whether the project is archived"
  type        = bool
  default     = false
}

variable "auto_cancel_pending_pipelines" {
  description = "Auto-cancel pending pipelines (enabled/disabled)"
  type        = string
  default     = "enabled"
}

variable "auto_devops_deploy_strategy" {
  description = "Auto Deploy strategy"
  type        = string
  default     = "continuous"
}

variable "auto_devops_enabled" {
  description = "Enable Auto DevOps"
  type        = bool
  default     = false
}

variable "autoclose_referenced_issues" {
  description = "Auto-close referenced issues"
  type        = bool
  default     = true
}

variable "avatar" {
  description = "Local path to avatar image"
  type        = string
  default     = null
}

variable "avatar_hash" {
  description = "Hash of the avatar image"
  type        = string
  default     = null
}

variable "build_git_strategy" {
  description = "Git strategy (clone/fetch)"
  type        = string
  default     = "fetch"
}

variable "build_timeout" {
  description = "Max job run time in seconds"
  type        = number
  default     = "3600"
}

variable "builds_access_level" {
  description = "Builds access level"
  type        = string
  default     = "enabled"
}

variable "ci_config_path" {
  description = "Custom CI config file path"
  type        = string
  default     = null
}

variable "ci_default_git_depth" {
  description = "Default shallow clone depth"
  type        = number
  default     = null
}

variable "ci_delete_pipelines_in_seconds" {
  description = "Pipeline retention in seconds"
  type        = number
  default     = null
}

variable "ci_forward_deployment_enabled" {
  description = "Skip older pending deployment jobs"
  type        = bool
  default     = false
}

variable "ci_pipeline_variables_minimum_override_role" {
  description = "Min role to override pipeline variables"
  type        = string
  default     = "maintainer"
}

variable "ci_separated_caches" {
  description = "Use separate caches for protected branches"
  type        = bool
  default     = true
}

variable "container_expiration_policy" {
  description = "Set the image cleanup policy for this project."
  type = list(object({
    cadence          = string
    enabled          = bool
    keep_n           = number
    name_regex_delete = string
    name_regex_keep  = string
    older_than       = string
  }))
  default = [
    {
      cadence          = "1d"
      enabled          = true
      keep_n           = 10
      name_regex_delete = ".*"
      name_regex_keep  = "(v.+|main|master|dev|staging|production)"
      older_than       = "7d"
    }
  ]
}

variable "container_registry_access_level" {
  description = "Set visibility of container registry for the project."
  type        = string
  default     = "enabled"
}

variable "default_branch" {
  description = "The default branch for the project."
  type        = string
  default     = "dev"
}

variable "description" {
  description = "A description of the project."
  type        = string
  default     = "Managed by terraform."
}

variable "emails_enabled" {
  description = "Enable email notifications."
  type        = bool
  default     = true
}

variable "environments_access_level" {
  description = "Set the environments access level."
  type        = string
  default     = "enabled"
}

variable "feature_flags_access_level" {
  description = "Set the feature flags access level."
  type        = string
  default     = "enabled"
}

variable "forking_access_level" {
  description = "Set the forking access level."
  type        = string
  default     = "enabled"
}

variable "group_runners_enabled" {
  description = "Enable group runners for this project."
  type        = bool
  default     = true
}

variable "group_with_project_templates_id" {
  description = "For group-level custom templates, specifies ID of group from which all the custom project templates are sourced."
  type        = number
  default     = null
}

variable "infrastructure_access_level" {
  description = "Set the infrastructure access level."
  type        = string
  default     = "enabled"
}

variable "initialize_with_readme" {
  description = "Create main branch with first commit containing a README.md file."
  type        = bool
  default     = true
}

variable "issues_access_level" {
  description = "Set the issues access level."
  type        = string
  default     = "enabled"
}

variable "issues_enabled" {
  description = "Enable issue tracking for the project."
  type        = bool
  default     = true
}

variable "keep_latest_artifact" {
  description = "Disable or enable the ability to keep the latest artifact for this project."
  type        = bool
  default     = true
}

variable "lfs_enabled" {
  description = "Enable LFS for the project."
  type        = bool
  default     = true
}

variable "merge_commit_template" {
  description = "Template used to create merge commit message in merge requests."
  type        = string
  default     = <<EOF
Merge branch '{{ source_branch }}' into '{{ target_branch }}'

Closes {{ issue_id }} - {{ issue_title }}

Описание изменений:
- [Краткое описание изменений, сделанных в MR]
EOF
}

variable "merge_method" {
  description = "Set the merge method."
  type        = string
  default     = "merge"
}

variable "merge_requests_access_level" {
  description = "Set the merge requests access level."
  type        = string
  default     = "enabled"
}

variable "merge_requests_enabled" {
  description = "Enable merge requests for the project."
  type        = bool
  default     = true
}

variable "model_experiments_access_level" {
  description = "Set visibility of machine learning model experiments."
  type        = string
  default     = "enabled"
}

variable "model_registry_access_level" {
  description = "Set visibility of machine learning model registry."
  type        = string
  default     = "enabled"
}

variable "monitor_access_level" {
  description = "Set the monitor access level."
  type        = string
  default     = "enabled"
}

variable "namespace_id" {
  description = "The namespace (group or user) of the project."
  type        = number
  default     = 0
}

variable "only_allow_merge_if_all_discussions_are_resolved" {
  description = "Set to true if you want allow merges only if all discussions are resolved."
  type        = bool
  default     = true
}

variable "only_allow_merge_if_pipeline_succeeds" {
  description = "Set to true if you want allow merges only if a pipeline succeeds."
  type        = bool
  default     = true
}

variable "packages_enabled" {
  description = "Enable packages repository for the project."
  type        = bool
  default     = true
}

variable "pages_access_level" {
  description = "Enable pages access control."
  type        = string
  default     = "enabled"
}

variable "path" {
  description = "The path of the repository."
  type        = string
  default     = null
}

variable "printing_merge_request_link_enabled" {
  description = "Show link to create/view merge request when pushing from the command line."
  type        = bool
  default     = true
}

variable "push_rules" {
  description = "Push rules to enforce branch protection and commit standards for Terraform repositories"
  type = list(object({
    author_email_regex              = optional(string)
    branch_name_regex              = optional(string)
    commit_committer_check         = optional(bool)
    commit_committer_name_check    = optional(bool)
    commit_message_negative_regex  = optional(string)
    commit_message_regex           = optional(string)
    deny_delete_tag                = optional(bool)
    file_name_regex                = optional(string)
    max_file_size                  = optional(number)
    member_check                   = optional(bool)
    prevent_secrets                = optional(bool)
    reject_non_dco_commits         = optional(bool)
    reject_unsigned_commits        = optional(bool)
  }))
  default = [
    {
      author_email_regex              = ""
      branch_name_regex              = "^(feature|fix|hotfix|chore|refactor|release|ci|build|research|sync)/.+$"
      commit_committer_check         = true
      commit_committer_name_check    = true
      commit_message_negative_regex  = "(ssh:\\/\\/|http:\\/\\/|https:\\/\\/|password|secret|token)"
      commit_message_regex           = "^(no issue|[A-Z]{2,10}-\\d+) \\| (chore|fix|hotfix|refactor|perf|ci|build|feature|breaking|research|sync): .+$"
      deny_delete_tag                = true
      file_name_regex                = "(\\.jar|\\.exe|\\.env|\\.pem)$"
      max_file_size                  = 5
      member_check                   = true
      prevent_secrets                = true
      reject_non_dco_commits         = true
      reject_unsigned_commits        = true
    }
  ]
}

variable "releases_access_level" {
  description = "Set the releases access level."
  type        = string
  default     = "enabled"
}

variable "remove_source_branch_after_merge" {
  description = "Enable Delete source branch option by default for all new merge requests."
  type        = bool
  default     = true
}

variable "repository_access_level" {
  description = "Set the repository access level."
  type        = string
  default     = "enabled"
}

variable "repository_storage" {
  description = "Which storage shard the repository is on. (administrator only)"
  type        = string
  default     = "default"
}

variable "request_access_enabled" {
  description = "Allow users to request member access."
  type        = bool
  default     = true
}

variable "requirements_access_level" {
  description = "Set the requirements access level."
  type        = string
  default     = "enabled"
}

variable "resolve_outdated_diff_discussions" {
  description = "Automatically resolve merge request diffs discussions on lines changed with a push."
  type        = bool
  default     = true
}

variable "restrict_user_defined_variables" {
  description = "Allow only users with the Maintainer role to pass user-defined variables when triggering a pipeline."
  type        = bool
  default     = false
}

variable "security_and_compliance_access_level" {
  description = "Set the security and compliance access level."
  type        = string
  default     = "enabled"
}

variable "shared_runners_enabled" {
  description = "Enable shared runners for this project."
  type        = bool
  default     = true
}

variable "skip_wait_for_default_branch_protection" {
  description = "If true, the default behavior to wait for the default branch protection to be created is skipped."
  type        = bool
  default     = false
}

variable "snippets_access_level" {
  description = "Set the snippets access level."
  type        = string
  default     = "enabled"
}

variable "snippets_enabled" {
  description = "Enable snippets for the project."
  type        = bool
  default     = true
}

variable "squash_commit_template" {
  description = "Template used to create squash commit message in merge requests."
  type        = string
  default     = "Squash commit for MR"
}

variable "squash_option" {
  description = "Squash commits when merge request is merged."
  type        = string
  default     = "never"
}

variable "suggestion_commit_message" {
  description = "The commit message used to apply merge request suggestions."
  type        = string
  default     = "chore: suggestion applied by $${author}"
}

variable "tags" {
  description = "The list of tags for a project."
  type        = set(string)
  default     = []
}

variable "template_name" {
  description = "Name of a built-in project template."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Block with create/update/delete timeouts (optional)."
  type        = any
  default     = null
}

variable "topics" {
  description = "The list of topics for the project."
  type        = set(string)
  default     = []
}

variable "use_custom_template" {
  description = "Use either custom instance or group (with group_with_project_templates_id) project template (Enterprise Edition only). Group Tokens won't work — use a real user's Personal Access Token."
  type        = bool
  default     = false
}

variable "visibility_level" {
  description = "Set to public to create a public project. Valid values: private, internal, public."
  type        = string
  default     = "private"
}

variable "wiki_access_level" {
  description = "Set the wiki access level. Valid values: disabled, private, enabled."
  type        = string
  default     = "private"
}

variable "wiki_enabled" {
  description = "Enable wiki for the project."
  type        = bool
  default     = true
}