resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  project       = var.project
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.subnet_cidr

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = var.pods_cidr
  }
  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = var.services_cidr
  }
}

resource "google_compute_firewall" "goclaw_gateway" {
  name    = "${var.environment}-allow-goclaw-gke"
  network = google_compute_network.vpc.name
  project = var.project

  allow {
    protocol = "tcp"
    ports    = [var.goclaw_port]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gke-${var.cluster_name}"]
}
