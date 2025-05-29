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
    }
  }
}

locals {
  user_memberships = yamldecode(file("users.yaml"))
}

inputs = {
  user_memberships = local.user_memberships
  user_ids_map = dependency.users.outputs.user_ids
}

