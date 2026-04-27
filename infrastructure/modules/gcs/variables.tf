variable "project" {
  type = string
}
variable "location" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "versioning" {
  type = bool
  default = true
}
variable "lifecycle_age" {
  type = number
  default = 90
}
variable "force_destroy" {
  type = bool
  default = false
}
variable "labels" {
  type = map(string)
  default = {}
}
variable "admin_members" {
  type = list(string)
  default = []
}
variable "viewer_members" {
  type = list(string)
  default = []
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "environment" {
  type = string
}
