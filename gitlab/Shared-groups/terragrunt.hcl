terraform {
  source = "../../modules/gitlab-shared-group"
}

include {
  path = find_in_parent_folders("root.hcl")
}

include "remote" {
  path = find_in_parent_folders("remote_state.hcl")
}

locals {
  basename = basename(get_terragrunt_dir())
}

inputs = {
  name = local.basename
  path = local.basename
}