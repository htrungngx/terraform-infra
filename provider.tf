terraform {
  backend "gcs" {
    bucket = "htrung-project-tfstate"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      version = "~> 4.68.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

locals {
  services = toset([
    "iam.googleapis.com",                  # Identity and Access Management (IAM) API
    "iamcredentials.googleapis.com",       # IAM Service Account Credentials API
    "cloudresourcemanager.googleapis.com", # Cloud Resource Manager API
    "sts.googleapis.com",                  # Security Token Service API
    "compute.googleapis.com",
    "storage.googleapis.com"
  ])
}
resource "google_project_service" "service" {
  for_each = local.services
  project  = var.project
  service  = each.value
  disable_dependent_services = false
  disable_on_destroy = false
}

resource "time_sleep" "wait_for_services" {
  depends_on = [google_project_service.service]
  create_duration = "120s"  # Adjust the wait time if needed
}



# resource "google_project_service" "project" {
#   project = google_project.my_project.id
#   service = "storage.googleapis.com"

#   timeouts {
#     create = "20m"
#     update = "20m"
#   }

#   disable_dependent_services = true
# }

# resource "google_project_service" "compute" {
#   project = google_project.my_project.id
#   service = "compute.googleapis.com"

#   timeouts {
#     create = "20m"
#     update = "20m"
#   }

#   disable_dependent_services = true
# }
