output "gke_node_sa_email" { value = google_service_account.gke_node.email }
output "goclaw_workload_sa_email" { value = google_service_account.goclaw_workload.email }
