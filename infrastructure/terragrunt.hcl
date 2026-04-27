# Root config shared across all environments

# Remote State (GCS)
remote_state {
  backend = "gcs"
  config = {
    project  = get_env("GOOGLE_PROJECT", "ai-core-system-bot-stg")
    location = get_env("GOOGLE_REGION", "asia-southeast2")
    bucket   = "${get_env("GOOGLE_PROJECT", "ai-core-system-bot-stg")}-terraform-state-${get_env("TF_VAR_env", "staging")}"
    prefix   = "${path_relative_to_include()}/terraform.tfstate"
    gcs_bucket_labels = {
      managed_by = "terragrunt"
      env        = get_env("TF_VAR_env", "staging")
    }
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Provider Configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<TFEOF
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = { source = "hashicorp/google", version = "~> 5.0" }
    kubernetes = { source = "hashicorp/kubernetes", version = "~> 2.23" }
    kubectl = { source = "alekc/kubectl", version = "~> 2.0" }
  }
}
provider "google" { project = var.project; region = var.region; zone = var.zone }
provider "kubernetes" { cluster_endpoint = module.gke.cluster_endpoint; token = data.google_client_config.current.access_token; cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate) }
provider "kubectl" { cluster_endpoint = module.gke.cluster_endpoint; token = data.google_client_config.current.access_token; cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate); load_config_file = false }
data "google_client_config" "current" {}
TFEOF
}

inputs = {
  project     = get_env("GOOGLE_PROJECT", "ai-core-system-bot-stg")
  region      = get_env("GOOGLE_REGION", "asia-southeast2")
  zone        = get_env("GOOGLE_ZONE", "asia-southeast2-b")
  environment = get_env("TF_VAR_env", "staging")
}
