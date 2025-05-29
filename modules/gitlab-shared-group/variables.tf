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

variable "description" {
  description = "Description of the group"
  type        = string
  default     = "Managed by Terraform"
}

variable "memberships" {
  description = "Optional map of user memberships with user_id and access_level"
  type = map(object({
    user_id      = number
    access_level = string
  }))
  default = {}
}