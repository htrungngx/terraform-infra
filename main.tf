resource "google_compute_instance" "deployment" {
  project                   = google_project.my_project.project_id
  name                      = "dev-deployment-vm"
  machine_type              = "e2-medium"
  zone                      = "europe-west2-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = google_project.my_project.project_id

    access_config {
      nat_ip = google_compute_address.dev_static_ip.address
    }
  }

  tags = ["deployment"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")

  metadata = {
    ssh-keys = "gcp_htrung:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFn9j8O5gIk45c6E/4lJ1K/BInF98KVsIqpzNiJd1ZNB gcp_htrung"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}

resource "google_compute_instance" "database-jfrog" {
  project                   = google_project.my_project.project_id
  name                      = "dev-database-jfrog-vm"
  machine_type              = "e2-medium"
  zone                      = "europe-west2-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = google_project.my_project.project_id


    access_config {
      nat_ip = google_compute_address.dev_database_static_ip.address
    }
  }

  tags = ["database"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")

  metadata = {
    ssh-keys = "gcp_htrung:${file("${path.module}/ssh-keys/keys.pub")}"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}

# resource "google_compute_instance" "jfrog" {
#   project                   = google_project.my_project.project_id
#   name                      = "dev-jfrog-vm"
#   machine_type              = "e2-small"
#   zone                      = "europe-west2-b"
#   allow_stopping_for_update = true

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-os-cloud/ubuntu-2204-lts"
#       size  = 30
#     }
#   }
#   network_interface {
#     subnetwork         = google_compute_network.network.name
#     subnetwork_project = google_project.my_project.project_id


#     access_config {
#       nat_ip = google_compute_address.dev_jfrog_static_ip.address
#     }
#   }

#   tags = ["jfrog"]

#   metadata_startup_script = file("${path.module}/app-script/initial-script.sh")

#   lifecycle {
#     ignore_changes = [
#       metadata
#     ]
#   }

# }

resource "google_compute_instance" "staging" {
  project                   = google_project.my_project.project_id
  name                      = "dev-staging-vm"
  machine_type              = "e2-small"
  zone                      = "europe-west2-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = google_project.my_project.project_id


    access_config {
      nat_ip = google_compute_address.dev_staging_static_ip.address
    }
  }

  tags = ["staging"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")
    
  metadata = {
    ssh-keys = "gcp_htrung:${file("${path.module}/ssh-keys/keys.pub")}"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}
resource "google_compute_instance" "gitlab" {
  project                   = google_project.my_project.project_id
  name                      = "dev-gitlab-vm"
  machine_type              = "e2-medium"
  zone                      = "europe-west2-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = google_project.my_project.project_id


    access_config {
      nat_ip = google_compute_address.dev_gitlab_static_ip.address
    }
  }

  tags = ["gitlab"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")

  metadata = {
    ssh-keys = "gcp_htrung:${file("${path.module}/ssh-keys/keys.pub")}"
  }
  
  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}

