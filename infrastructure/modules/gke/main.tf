resource "google_container_cluster" "goclaw" {
  name     = var.cluster_name
  location = var.zone
  project  = var.project
  network    = var.network
  subnetwork = var.subnetwork

  # Only set enable_autopilot when true
  enable_autopilot = var.enable_autopilot ? true : null

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project}.svc.id.goog"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  # Remove default node pool for non-autopilot, managed by separate resource
  remove_default_node_pool = true
  initial_node_count = 1

  lifecycle {
    ignore_changes = [node_config]
  }
}

resource "google_container_node_pool" "default" {
  count = var.enable_autopilot ? 0 : 1

  name       = "default-pool"
  cluster    = google_container_cluster.goclaw.name
  project    = var.project
  location   = var.zone

  initial_node_count = var.node_pool_min_count

  autoscaling {
    min_node_count = var.node_pool_min_count
    max_node_count = var.node_pool_max_count
  }

  node_config {
    machine_type    = var.node_pool_machine_type
    disk_size_gb    = var.node_pool_disk_size_gb
    disk_type       = var.node_pool_disk_type
    service_account = var.service_account
    preemptible     = var.node_pool_preemptible
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
