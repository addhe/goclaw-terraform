variable "project" {
  type = string
}
variable "region" {
  type = string
}
variable "environment" {
  type = string
}
variable "network_name" {
  type = string
}
variable "subnet_name" {
  type = string
}
variable "subnet_cidr" {
  type = string
}
variable "pods_cidr" {
  type = string
  default = "10.20.16.0/20"
}
variable "services_cidr" {
  type = string
  default = "10.20.32.0/20"
}
variable "create_secondary_ranges" {
  type = bool
  default = true
}
variable "cluster_name" {
  type = string
}
variable "goclaw_port" {
  type = number
  default = 18790
}

variable "zone" {
  type = string
}
