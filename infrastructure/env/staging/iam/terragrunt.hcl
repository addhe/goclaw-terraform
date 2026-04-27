include "root" {
  path   = find_in_parent_folders("infrastructure/terragrunt.hcl")
  expose = true
}

terraform {
  source = "${dirname(find_in_parent_folders("infrastructure/terragrunt.hcl"))}//modules/iam"
}

locals {
  env = read_terragrunt_config("${dirname(find_in_parent_folders("infrastructure/terragrunt.hcl"))}/env/staging/env.hcl").locals
}

inputs = merge(local.env, {})
