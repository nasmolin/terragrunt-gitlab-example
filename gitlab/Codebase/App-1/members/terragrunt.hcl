terraform {
  source = "../../../../modules/memberships-generator"
}

include {
  path = find_in_parent_folders("root.hcl")
}

include "remote" {
  path = find_in_parent_folders("remote_state.hcl")
}

dependency "users" {
  config_path = "../../../Users"
  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    user_ids = {
      "developer.user@example.com"  = "9999"
      "maintainer.user@example.com" = "9999"
      "owner.user@example.com"      = "9999"
    }
  }
}

inputs = {
  developers  = ["developer.user@example.com"]
  maintainers = ["maintainer.user@example.com"]
  owners      = ["owner.user@example.com"]

  user_ids_map = dependency.users.outputs.user_ids
}

