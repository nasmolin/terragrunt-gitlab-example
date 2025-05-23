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
    }
    "maintainer.user@example.com" = {
      email    = "maintainer.user@example.com"
      name     = "Maintainer User"
      username = "maintainer.user"
      state    = "active"
    }
  }
}

