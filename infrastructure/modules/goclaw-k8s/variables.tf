variable "environment" {
  type = string
}
variable "goclaw_image" {
  type = string
}
variable "goclaw_version" {
  type = string
}
variable "goclaw_replicas" {
  type = number
}
variable "goclaw_port" {
  type = number
  default = 18790
}
variable "namespace" {
  type = string
  default = "goclaw"
}
variable "gateway_token" {
  type = string, sensitive = true
}
variable "encryption_key" {
  type = string, sensitive = true
}
variable "admir_password" {
  type = string, sensitive = true
}
variable "postgres_password" {
  type = string, sensitive = true
}
variable "ollama_api_key" {
  type = string, sensitive = true
}
variable "telegram_bot_token" {
  type = string, sensitive = true
}
variable "telegram_bot_token_support" {
  type = string, sensitive = true
}
variable "goclaw_domain" {
  type = string
  default = ""
}
variable "ssl_certificate_name" {
  type = string
  default = ""
}
variable "backup_schedule" {
  type = string
  default = "0 2 * * *"
}
variable "goclaw_data_storage" {
  type = string
  default = "5Gi"
}
variable "goclaw_workspace_storage" {
  type = string
  default = "10Gi"
}
variable "storage_class" {
  type = string
  default = "standard"
}
variable "postgres_storage" {
  type = string
  default = "10Gi"
}
variable "use_cloud_sql" {
  type = bool
  default = false
}
variable "cloud_sql_connection_name" {
  type = string
  default = ""
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "project" {
  type = string
}
