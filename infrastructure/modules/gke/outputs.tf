output "cluster_name"           { value = google_container_cluster.goclaw.name }
output "cluster_endpoint"       { value = google_container_cluster.goclaw.endpoint }
output "cluster_ca_certificate" { value = google_container_cluster.goclaw.master_auth[0].cluster_ca_certificate }
output "cluster_location"       { value = google_container_cluster.goclaw.location }
