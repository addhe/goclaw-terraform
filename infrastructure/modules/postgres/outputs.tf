output "cloud_sql_connection_name" {
  value = var.use_cloud_sql ? google_sql_database_instance.goclaw[0].connection_name : ""
}
output "use_cloud_sql" { value = var.use_cloud_sql }
