resource "google_sql_database_instance" "goclaw" {
  count          = var.use_cloud_sql ? 1 : 0
  name            = "goclaw-${var.environment}"
  project          = var.project
  region          = var.region
  database_version = "POSTGRES_14"
  settings {
    tier = var.cloud_sql_tier
    disk_size = var.cloud_sql_disk_size
    disk_type = var.cloud_sql_disk_type
    backup_configuration {
      enabled    = var.backup_enabled
      start_time = "02:00"
    }
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_network != "" ? var.private_network : null
    }
    database_flags {
      name  = "max_connections"
      value = "100"
    }
  }
  deletion_protection = var.environment == "production"
}

resource "google_sql_database" "goclaw" {
  count    = var.use_cloud_sql ? 1 : 0
  name     = var.postgres_db
  project  = var.project
  instance = google_sql_database_instance.goclaw[0].name
}

resource "google_sql_user" "goclaw" {
  count    = var.use_cloud_sql ? 1 : 0
  name     = var.postgres_user
  project  = var.project
  instance = google_sql_database_instance.goclaw[0].name
  password = var.postgres_password
}
