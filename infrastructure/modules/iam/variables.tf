variable "project" {
  type = string
}
variable "environment" {
  type = string
}
variable "node_sa_name" {
  type = string
}
variable "workload_sa_name" {
  type = string
}
variable "backup_buckets" {
  type = set(string)
  default = []
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}
