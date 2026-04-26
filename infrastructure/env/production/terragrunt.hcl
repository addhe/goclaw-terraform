include "root" {
  path = find_in_parent_folders()
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env/production/env.hcl")).locals
}

inputs = merge(
  local.env,
  {
    goclaw_gateway_token  = get_env("GOCLAW_GATEWAY_TOKEN_PRD", "")
    goclaw_encryption_key = get_env("GOCLAW_ENCRYPTION_KEY_PRD", "")
    goclaw_admin_password = get_env("GOCLAW_ADMIN_PASSWORD_PRD", "")
    postgres_password     = get_env("GOCLAW_POSTGRES_PASSWORD_PRD", "")
  }
)
