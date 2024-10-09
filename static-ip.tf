resource "google_compute_address" "dev_static_ip" {
  name    = "dev-static-ip"
  project = var.project
  region  = var.region
}

resource "google_compute_address" "dev_database_static_ip" {
  name    = "dev-database-static-ip"
  project = var.project
  region  = var.region
}
# resource "google_compute_address" "dev_jfrog_static_ip" {
#   name    = "dev-jrog-static-ip"
#   project = google_project.my_project.project_id
#   region  = "europe-west2"
# }
resource "google_compute_address" "dev_staging_static_ip" {
  name    = "dev-staging-static-ip"
  project = var.project
  region  = var.region
}
resource "google_compute_address" "dev_gitlab_static_ip" {
  name    = "dev-gitlab-static-ip"
  project = var.project
  region  = var.region
}
resource "google_compute_address" "k8s_master_static_ip" {
  name    = "k8s-master-static-ip"
  project = var.project
  region  = var.region
}
resource "google_compute_address" "k8s_node1_static_ip" {
  name    = "k8s-node1-static-ip"
  project = var.project
  region  = var.region
}
resource "google_compute_address" "k8s_node2_static_ip" {
  name    = "k8s-node2-static-ip"
  project = var.project
  region  = var.region
}
resource "google_compute_address" "k8s_node3_static_ip" {
  name    = "k8s-node3-static-ip"
  project = var.project
  region  = var.region
}
