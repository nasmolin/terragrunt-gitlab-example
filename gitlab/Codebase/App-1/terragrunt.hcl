terraform {
  source = "../../../modules/gitlab-group"
}

include {
  path = find_in_parent_folders("root.hcl")
}

include "remote" {
  path = find_in_parent_folders("remote_state.hcl")
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

dependency "generate-group-variables" {
  config_path = "./secrets"
  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    generated_secrets = {
      "DUMMY" = {
        key           = "TF_MOCK_KEY"
        value         = "TF_MOCK_VALUE"
        description   = "Managed by Terraform. DUMMY."
        protected     = true
        masked        = true
      }
    }
  }
}

locals {
  basename = basename(get_terragrunt_dir())
}

inputs = {
  name = local.basename
  path = local.basename
  
  group_variables = {
    for key, val in dependency.generate-group-variables.outputs.generated_secrets :
    key => {
      key           = val.key
      value         = val.value
      description   = val.description
      protected     = val.protected
      masked        = val.masked
    }
  }

  memberships = dependency.members.outputs.generated_memberships
}

