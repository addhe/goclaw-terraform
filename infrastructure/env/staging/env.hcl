locals {
  env         = "staging"
  env_short   = "stg"
  project     = "ai-core-system-bot-stg"
  region      = "asia-southeast2"
  zone        = "asia-southeast2-a"

  # GKE
  cluster_name            = "goclaw-stg"
  cluster_version         = "1.29"
  enable_autopilot        = false
  node_pool_machine_type  = "e2-medium"
  node_pool_min_count     = 1
  node_pool_max_count     = 3
  node_pool_preemptible   = true

  # GCS state bucket
  state_bucket = "ai-core-system-bot-stg-terraform-state-staging"

  # GoClaw
  goclaw_version  = "3.11.2"
  goclaw_replicas = 1
  goclaw_image    = "asia-southeast2-docker.pkg.dev/ai-core-system-bot-stg/goclaw/goclaw"

  # Database
  use_cloud_sql    = false
  postgres_tier    = "db-f1-micro"
  postgres_disk    = 10
  postgres_storage = "10Gi"

  # Network
  network_name = "goclaw-staging-network"
  subnet_name  = "goclaw-staging-subnet"
  subnet_cidr  = "10.20.0.0/24"
  pods_cidr    = "10.20.16.0/20"
  services_cidr = "10.20.32.0/20"

  # Backup
  backup_bucket = "goclaw-k8s-backups-stg"
  backup_schedule = "0 2 * * *"

  # Domain
  goclaw_domain = ""

  # Resource tags
  tags = {
    environment = "staging"
    managed_by  = "terragrunt"
    project     = "goclaw"
  }
}
