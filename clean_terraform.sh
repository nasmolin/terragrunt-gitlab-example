#!/bin/bash

find . -type d -name ".terraform" -exec rm -rf {} +

find . -type f -name ".terraform.lock.hcl" -exec rm -f {} +

find . -type d -name ".terragrunt-cache" -exec rm -rf {} +

echo "[SUCCESS] Completed."