terraform {
  source = "${get_parent_terragrunt_dir()}/modules/gke"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env/production/env.hcl")).locals
}

inputs = merge(local.env, {
  network     = local.env.network_name
  subnetwork  = local.env.subnet_name
  service_account = "gke-node-sa@${local.env.project}.iam.gserviceaccount.com"
})
