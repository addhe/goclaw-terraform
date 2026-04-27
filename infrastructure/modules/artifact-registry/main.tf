resource "google_artifact_registry_repository" "goclaw" {
  project       = var.project
  location      = var.location
  repository_id = var.repository_name
  format        = "DOCKER"
  description   = "GoClaw images for ${var.environment}"
  labels        = var.labels
}

resource "google_artifact_registry_repository_iam_binding" "readers" {
  project    = var.project
  location   = var.location
  repository = google_artifact_registry_repository.goclaw.name
  role       = "roles/artifactregistry.reader"
  members    = var.reader_members
}

resource "google_artifact_registry_repository_iam_binding" "writers" {
  project    = var.project
  location   = var.location
  repository = google_artifact_registry_repository.goclaw.name
  role       = "roles/artifactregistry.writer"
  members    = var.writer_members
}
