variable "project" {
  type = string
}
variable "location" {
  type = string
}
variable "repository_name" {
  type = string
  default = "goclaw"
}
variable "environment" {
  type = string
}
variable "labels" {
  type = map(string)
  default = {}
}
variable "reader_members" {
  type = list(string)
  default = []
}
variable "writer_members" {
  type = list(string)
  default = []
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}
