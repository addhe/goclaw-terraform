include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/network"
}

locals {
  env = read_terragrunt_config("../../env.hcl").locals
}

inputs = {
  project       = local.env.project
  region        = local.env.region
  environment   = local.env.env
  network_name  = local.env.network_name
  subnet_name   = local.env.subnet_name
  subnet_cidr   = local.env.subnet_cidr
  pods_cidr     = local.env.pods_cidr
  services_cidr = local.env.services_cidr
  cluster_name  = local.env.cluster_name
  goclaw_port   = 18790
}
