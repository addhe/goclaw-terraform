terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = { source = "hashicorp/kubernetes", version = "~> 2.23" }
    kubectl = { source = "alekc/kubctl", version = "~> 2.0" }
  }
}
