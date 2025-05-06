# Общие настройки для всех папок ниже

locals {
  gitlab_token = get_env("GITLAB_API_TOKEN")
  gitlab_url   = get_env("GITLAB_API_URL")
  terraform_ignore_tfvars = true
}

remote_state {
  backend = "local"

  config = {
    path = "terraform.tfstate"
  }
}

terraform {}

inputs = {
  gitlab_token = local.gitlab_token
  gitlab_url   = local.gitlab_url
}