resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  project       = var.project
  location      = var.location
  force_destroy = var.force_destroy
  versioning { enabled = var.versioning }
  lifecycle_rule {
    condition { age = var.lifecycle_age }
    action { type = "SetStorageClass"; storage_class = "COLD" }
  }
  lifecycle_rule {
    condition { num_newer_versions = 10; with_state = "ANY" }
    action { type = "Delete" }
  }
  labels = var.labels
}

resource "google_storage_bucket_iam_binding" "admins" {
  for_each = toset(var.admin_members)
  bucket  = google_storage_bucket.bucket.name
  role    = "roles/storage.objectAdmin"
  members = [each.value]
}

resource "google_storage_bucket_iam_binding" "viewers" {
  count = length(var.viewer_members) > 0 ? 1 : 0
  bucket  = google_storage_bucket.bucket.name
  role    = "roles/storage.objectViewer"
  members = var.viewer_members
}
