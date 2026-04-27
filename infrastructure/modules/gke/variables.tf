variable "project" {
  type = string
}
variable "region" {
  type = string
}
variable "zone" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "cluster_version" {
  type = string
}
variable "network" {
  type = string
}
variable "subnetwork" {
  type = string
}
variable "environment" {
  type = string
}
variable "service_account" {
  type = string
}
variable "tags" {
  type = map(string)
  default = {}
}
variable "enable_autopilot" {
  type = bool
  default = false
}
variable "node_pool_machine_type" {
  type = string
  default = "e2-medium"
}
variable "node_pool_min_count" {
  type = number
  default = 1
}
variable "node_pool_max_count" {
  type = number
  default = 3
}
variable "node_pool_preemptible" {
  type = bool
  default = false
}
variable "node_pool_disk_size_gb" {
  type = number
  default = 50
}
variable "node_pool_disk_type" {
  type = string
  default = "pd-standard"
}
