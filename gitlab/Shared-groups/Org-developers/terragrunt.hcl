terraform {
  source = "../../../modules/gitlab-shared-group"
}

include {
  path = find_in_parent_folders("root.hcl")
}

include "remote" {
  path = find_in_parent_folders("remote_state.hcl")
}

dependency "parent_group" {
  config_path = "../"
  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    group_id  = 9999
  }
}

dependency "members" {
  config_path = "./members"
  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    generated_memberships  = {
      "mock.user@example.com" = {
        user_id      = 9999
        access_level = "no one"
      }
    }
  }
}

dependency "users" {
  config_path = "../../Users"
  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    user_ids  = {
      "mock.user@example.com" = 9999
    }
  }
}

locals {
  basename = basename(get_terragrunt_dir())
}

inputs = {
  name = local.basename
  path = local.basename

  parent_id = dependency.parent_group.outputs.group_id
  memberships = dependency.members.outputs.generated_memberships
}