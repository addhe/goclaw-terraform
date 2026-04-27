include "root" {
  path = "../../../terragrunt.hcl"
}

terraform {
  source = "../../../modules/postgres"
}

locals {
  env = read_terragrunt_config("../env.hcl").locals
}

inputs = {
  project           = local.env.project
  region            = local.env.region
  environment       = local.env.env
  use_cloud_sql     = local.env.use_cloud_sql
  postgres_password = get_env("GOCLAW_POSTGRES_PASSWORD_STG", "changeme")
}
