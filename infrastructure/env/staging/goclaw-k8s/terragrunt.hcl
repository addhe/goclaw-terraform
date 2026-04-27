include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/goclaw-k8s"
}

locals {
  env = read_terragrunt_config("../../env.hcl").locals
}

inputs = {
  environment                = local.env.env
  goclaw_image               = local.env.goclaw_image
  goclaw_version             = local.env.goclaw_version
  goclaw_replicas            = local.env.goclaw_replicas
  goclaw_port                = 18790
  namespace                  = "goclaw"
  gateway_token              = get_env("GOCLAW_GATEWAY_TOKEN_STG", "changeme")
  encryption_key             = get_env("GOCLAW_ENCRYPTION_KEY_STG", "changeme")
  admin_password             = get_env("GOCLAW_ADMIN_PASSWORD_STG", "changeme")
  postgres_password          = get_env("GOCLAW_POSTGRES_PASSWORD_STG", "changeme")
  ollama_api_key             = ""
  telegram_bot_token         = get_env("TELEGRAM_BOT_TOKEN_STG", "")
  telegram_bot_token_support = get_env("TELEGRAM_BOT_TOKEN_SUPPORT_STG", "")
  goclaw_domain              = local.env.goclaw_domain
  backup_schedule            = local.env.backup_schedule
  goclaw_data_storage        = "5Gi"
  goclaw_workspace_storage   = "10Gi"
  storage_class              = "standard"
  postgres_storage           = "10Gi"
  use_cloud_sql              = local.env.use_cloud_sql
}
