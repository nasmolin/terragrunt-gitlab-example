terraform {
  source = "../../modules/gitlab-user"
}

include {
  path = find_in_parent_folders("root.hcl")
}

include "remote" {
  path = find_in_parent_folders("remote_state.hcl")
}

inputs = {
  users = {
    "developer.user@example.com" = {
      email    = "developer.user@example.com"
      name     = "Developer User"
      username = "developer.user"
      state    = "active"
      create_user = true
      is_admin    = false
    }
    "maintainer.user@example.com" = {
      email    = "maintainer.user@example.com"
      name     = "Maintainer User"
      username = "maintainer.user"
      state    = "active"
      create_user = true
      is_admin    = false 
    }
    "owner.user@example.com" = {
      email    = "owner.user@example.com"
      name     = "Owner User"
      username = "owner.user"
      state    = "active"
      create_user = true
      is_admin    = false
    }
  }
}

