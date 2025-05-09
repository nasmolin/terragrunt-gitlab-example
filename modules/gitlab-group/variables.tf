variable "name" {
  description = "Name of the GitLab group"
  type        = string
}

variable "path" {
  description = "Relative path"
  type        = string
}

variable "parent_id" {
  description = "ID of parent group"
  type        = number
  default     = 0
}

variable "variables" {
  description = "Gitlab-ci group variables"
  type = map(object({
    value     = string
    protected = optional(bool)
    masked    = optional(bool)
  }))
  default = {}
}

variable "visibility" {
  description = "Visibility level of the group"
  type        = string
  default     = "private"
}

variable "require_two_factor_authentication" {
  description = "Enable two-factor authentication requirement"
  type        = bool
  default     = false
}

variable "auto_devops_enabled" {
  description = "Enable Auto DevOps for the group"
  type        = bool
  default     = false
}

variable "extra_shared_runners_minutes_limit" {
  description = "Additional shared runners minutes limit for the group"
  type        = number
  default     = 0
}

variable "prevent_forking_outside_group" {
  description = "Prevent forking of the group's projects outside the group"
  type        = bool
  default     = false
}

variable "project_creation_level" {
  description = "Level of project creation allowed in the group"
  type        = string
  default     = "developer"
}

variable "request_access_enabled" {
  description = "Enable request access for users who are not members of the group"
  type        = bool
  default     = true
}

variable "shared_runners_minutes_limit" {
  description = "Shared runners minutes limit for the group"
  type        = number
  default     = 0
}

variable "subgroup_creation_level" {
  description = "Level of subgroup creation allowed in the group"
  type        = string
  default     = "owner"
}

variable "two_factor_grace_period" {
  description = "Grace period before two-factor authentication is enforced"
  type        = number
  default     = 48
}

variable "lfs_enabled" {
  description = "Enable Large File Storage (LFS) for the group"
  type        = bool
  default     = true
}

variable "mentions_disabled" {
  description = "Disable mentions for the group"
  type        = bool
  default     = false
}

variable "description" {
  description = "Description of the group"
  type        = string
  default     = "Managed by Terraform"
}

variable "share_with_group_lock" {
  description = "Lock sharing with the GitLab group"
  type        = bool
  default     = false
}