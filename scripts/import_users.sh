#!/bin/bash

WORKDIR="gitlab/Users"

read -r -d '' USERS << EOM
user2import1@example.com 1
user2import2@example.com 2
user2import3@example.com 3
user2import4@example.com 4
user2import5@example.com 5
EOM

while read -r email id; do
  if [[ -n "$email" && -n "$id" ]]; then
    echo "Importing $email with ID $id..."
    terragrunt --terragrunt-working-dir "$WORKDIR" import "gitlab_user.imported[\"$email\"]" "$id"
  fi
done <<< "$USERS"
