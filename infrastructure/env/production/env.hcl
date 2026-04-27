locals {
  env         = "production"
  env_short   = "prd"
  project     = "ai-core-system-bot-stg"
  region      = "asia-southeast2"
  zone        = "asia-southeast2-b"

  # GKE
  cluster_name            = "goclaw-prd"
  cluster_version         = "1.29"
  enable_autopilot        = true
  node_pool_machine_type  = "e2-standard-2"
  node_pool_min_count     = 1
  node_pool_max_count     = 5
  node_pool_preemptible   = false

  # GoClaw
  goclaw_version  = "3.11.2"
  goclaw_replicas = 2
  goclaw_image    = "asia-southeast2-docker.pkg.dev/ai-core-system-bot-stg/goclaw/goclaw"

  # Database
  use_cloud_sql    = true
  postgres_tier    = "db-custom-2-7680"
  postgres_disk    = 20
  postgres_storage = "20Gi"

  # Network
  network_name = "goclaw-production-network"
  subnet_name  = "goclaw-production-subnet"
  subnet_cidr  = "10.30.0.0/24"
  pods_cidr    = "10.30.16.0/20"
  services_cidr = "10.30.32.0/20"

  # Backup
  backup_bucket = "goclaw-k8s-backups-prd"
  backup_schedule = "0 2 * * *"

  # Domain
  goclaw_domain = "goclaw.example.com"

  # Resource tags
  tags = {
    environment = "production"
    managed_by  = "terragrunt"
    project     = "goclaw"
  }
}
