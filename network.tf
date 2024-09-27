resource "google_compute_network" "network" {
  name    = "dev-network"
  project = var.project
}

resource "google_compute_firewall" "http" {
  name    = "dev-firewall"
  network = google_compute_network.network.name
  project = var.project
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22", "8978", "8082", "1433", "3000", "5241", "8081", "8978" ]
  }

  target_tags   = ["deployment", "database", "jfrog", "staging", "gitlab"]
  source_ranges = ["0.0.0.0/0"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

}


