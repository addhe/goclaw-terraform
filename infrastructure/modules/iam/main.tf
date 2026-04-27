resource "google_service_account" "gke_node" {
  account_id   = var.node_sa_name
  project      = var.project
  display_name = "GKE Node SA for ${var.environment}"
}

resource "google_project_iam_member" "gke_node_roles" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
  ])
  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.gke_node.email}"
}

resource "google_service_account" "goclaw_workload" {
  account_id   = var.workload_sa_name
  project      = var.project
  display_name = "GoClaw Workload SA for ${var.environment}"
}

# Workload Identity binding will be added after GKE cluster is created
# resource "google_service_account_iam_binding" "workload_identity" {
#   service_account_id = google_service_account.goclaw_workload.name
#   role               = "roles/iam.workloadIdentityUser"
#   members = ["serviceAccount:${var.project}.svc.id.goog[goclaw/goclaw-sa]"]
# }

resource "google_storage_bucket_iam_member" "goclaw_backup_access" {
  for_each = var.backup_buckets
  bucket   = each.value
  role     = "roles/storage.objectAdmin"
  member   = "serviceAccount:${google_service_account.goclaw_workload.email}"
}

resource "google_project_iam_member" "secret_accessor" {
  project = var.project
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.goclaw_workload.email}"
}
