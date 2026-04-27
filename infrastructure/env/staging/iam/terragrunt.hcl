include "root" {
  path = "../../../terragrunt.hcl"
}

terraform {
  source = "../../../modules/iam"
}

locals {
  env = read_terragrunt_config("../env.hcl").locals
}

inputs = {
  project           = local.env.project
  environment       = local.env.env
  node_sa_name      = "gke-node-sa"
  workload_sa_name  = "goclaw-workload-sa"
  backup_buckets    = [local.env.backup_bucket]
}
