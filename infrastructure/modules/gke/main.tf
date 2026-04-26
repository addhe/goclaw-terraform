resource "google_container_cluster" "goclaw" {
  name     = var.cluster_name
  location = var.region
  project  = var.project
  network    = var.network
  subnetwork = var.subnetwork
  enable_autopilot = var.enable_autopilot
  release_channel { channel = "REGULAR" }
  workload_pool_config { workload_pool = "${var.project}.svc.id.goog" }
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
  labels = var.tags
  dynamic "node_pool" {
    for_each = var.enable_autopilot ? [] : [1]
    content {
      name            = "default-pool"
      machine_type    = var.node_pool_machine_type
      min_count       = var.node_pool_min_count
      max_count       = var.node_pool_max_count
      preemptible     = var.node_pool_preemptible
      disk_size_gb    = var.node_pool_disk_size_gb
      disk_type       = var.node_pool_disk_type
      service_account = var.service_account
      management { auto_repair = true; auto_upgrade = true }
    }
  }
  remove_default_node_pool = var.enable_autopilot
  lifecycle { ignore_changes = [node_config] }
}
