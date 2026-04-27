variable "project" { type = string }
variable "region" { type = string }
variable "environment" { type = string }
variable "use_cloud_sql" { type = bool, default = false }
variable "cloud_sql_tier" { type = string, default = "db-f1-micro" }
variable "cloud_sql_disk_size" { type = number, default = 10 }
variable "cloud_sql_disk_type" { type = string, default = "PD_SSD" }
variable "postgres_user" { type = string, default = "goclaw" }
variable "postgres_password" { type = string, sensitive = true }
variable "postgres_db" { type = string, default = "goclaw" }
variable "backup_enabled" { type = bool, default = true }
variable "private_network" { type = string, default = "" }
