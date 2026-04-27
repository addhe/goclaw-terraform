include "root" {
  path = "../../../terragrunt.hcl"
}

terraform {
  source = "../../../modules/artifact-registry"
}

locals {
  env = read_terragrunt_config("../env.hcl").locals
}

inputs = {
  project         = local.env.project
  location        = local.env.region
  repository_name = "goclaw"
  environment     = local.env.env
  labels          = local.env.tags
  reader_members  = []
  writer_members  = ["serviceAccount:gke-deploy-admin@${local.env.project}.iam.gserviceaccount.com"]
}
