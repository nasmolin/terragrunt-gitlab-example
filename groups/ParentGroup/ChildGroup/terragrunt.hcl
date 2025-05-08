# Шаблон для групп после первого уровня.

terraform {
  source = "../../../modules/group"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "parent" {
  config_path = "../"
  mock_outputs = {
    id = "9999"
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

locals {
  basename = basename(get_terragrunt_dir())
}


inputs = {
  name      = local.basename
  path      = local.basename
  parent_id = dependency.parent.outputs.id
}
