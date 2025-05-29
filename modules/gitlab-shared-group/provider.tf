terraform {
  backend "s3" {}
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "= 17.11.0"
    }
  }
}

provider "gitlab" {
  token = var.gitlab_token
  base_url = var.gitlab_url
}

variable "gitlab_token" {
  description = "GitLab personal access token"
  type        = string
}

variable "gitlab_url" {
  description = "GitLab API URL"
  type        = string
}

