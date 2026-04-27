include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/gcs"
}

locals {
  env = read_terragrunt_config("../../env.hcl").locals
}

inputs = {
  project       = local.env.project
  location      = local.env.region
  bucket_name   = local.env.state_bucket
  versioning    = true
  lifecycle_age = 90
  force_destroy = false
  labels        = local.env.tags
  admin_members = ["serviceAccount:gke-deploy-admin@${local.env.project}.iam.gserviceaccount.com"]
}
