terraform {

  # backend "gcs" {
  #   bucket = "dev-app-project-bucket-tfstate"
  #   prefix = "terraform/state"
  # }

  required_providers {
    google = {
      version = "~> 4.68.0"
    }
  }
}

resource "google_project_service" "project" {
  project = google_project.my_project.id
  service = "storage.googleapis.com"

  timeouts {
    create = "20m"
    update = "20m"
  }

  disable_dependent_services = true
}

resource "google_project_service" "compute" {
  project = google_project.my_project.id
  service = "compute.googleapis.com"

  timeouts {
    create = "20m"
    update = "20m"
  }

  disable_dependent_services = true
}

resource "google_storage_bucket" "default" {
  name          = "dev-app-project-bucket-tfstate"
  project       = replace(google_project.my_project.id, "projects/", "")
  force_destroy = true
  location      = "EU"
  storage_class = "STANDARD"


  versioning {
    enabled = true
  }
}

resource "random_string" "project_prefix" {
  length  = 8
  special = false
  numeric = false
  lower   = true
  upper   = false

}

data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

resource "google_project" "my_project" {
  name            = "gcp-htrung-project"
  project_id      = "${random_string.project_prefix.result}-gcp-htrung-project"
  billing_account = data.google_billing_account.acct.id
}
