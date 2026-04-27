include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/gke"
}

locals {
  env = read_terragrunt_config("../../env.hcl").locals
}

inputs = {
  project                = local.env.project
  region                 = local.env.region
  zone                   = local.env.zone
  cluster_name           = local.env.cluster_name
  cluster_version        = local.env.cluster_version
  network                = local.env.network_name
  subnetwork             = local.env.subnet_name
  environment            = local.env.env
  service_account        = "gke-node-sa@${local.env.project}.iam.gserviceaccount.com"
  tags                   = local.env.tags
  enable_autopilot       = local.env.enable_autopilot
  node_pool_machine_type = local.env.node_pool_machine_type
  node_pool_min_count    = local.env.node_pool_min_count
  node_pool_max_count    = local.env.node_pool_max_count
  node_pool_preemptible  = local.env.node_pool_preemptible
}
