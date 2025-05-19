terraform {
  source = "../../../../../modules/gitlab-project"
}

include {
  path = find_in_parent_folders("root.hcl")
}


locals {
  basename = basename(get_terragrunt_dir())
}

dependency "parent" {
  config_path = "../../"
  mock_outputs = {
    id = "9999"
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

inputs = {
  name                                 = local.basename
  namespace_id                         = dependency.parent.outputs.id
}