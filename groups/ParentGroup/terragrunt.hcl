# Шаблон для групп первого уровня.

terraform {
  source = "../../modules/group"
}

include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  basename = basename(get_terragrunt_dir())
}

inputs = {
  name = local.basename
  path = local.basename
}

