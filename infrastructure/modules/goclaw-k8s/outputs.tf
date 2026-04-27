output "namespace" { value = kubernetes_namespace_v1.goclaw.metadata[0].name }
output "goclaw_service_name" { value = kubernetes_service_v1.goclaw.metadata[0].name }
output "goclaw_port" { value = var.goclaw_port }
output "postgres_service" { value = kubernetes_service_v1.postgres.metadata[0].name }
output "ingress_host" { value = var.goclaw_domain != "" ? var.goclaw_domain : "N/A" }
