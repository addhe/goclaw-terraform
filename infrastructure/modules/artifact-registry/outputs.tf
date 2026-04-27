output "repository_name" { value = google_artifact_registry_repository.goclaw.name }
output "repository_url"  { value = "${var.location}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.goclaw.repository_id}" }
