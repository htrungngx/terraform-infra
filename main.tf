resource "google_compute_instance" "deployment" {
  project                   = var.project
  name                      = "dev-deployment-vm"
  machine_type              = var.machine_type_small
  zone                      = var.zone
  allow_stopping_for_update = true
  depends_on = [ google_project_service.service, time_sleep.wait_for_services ]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = var.project

    access_config {
      nat_ip = google_compute_address.dev_static_ip.address
    }
  }

  tags = ["deployment"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/key.pub")}"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}

resource "google_compute_instance" "database-jfrog" {
  project                   = var.project
  name                      = "dev-database-jfrog-vm"
  machine_type              = var.machine_type_medium
  zone                      = var.zone
  allow_stopping_for_update = true
  depends_on = [ google_project_service.service, time_sleep.wait_for_services ]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = var.project

    access_config {
      nat_ip = google_compute_address.dev_database_static_ip.address
    }
  }

  tags = ["database"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/key.pub")}"
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
  project                   = var.project
  name                      = "dev-staging-vm"
  machine_type              = var.machine_type_small
  zone                      = var.zone
  allow_stopping_for_update = true
  depends_on = [ google_project_service.service, time_sleep.wait_for_services ]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = var.project


    access_config {
      nat_ip = google_compute_address.dev_staging_static_ip.address
    }
  }

  tags = ["staging"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")
    
  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/key.pub")}"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}
resource "google_compute_instance" "gitlab" {
  project                   = var.project
  name                      = "dev-gitlab-vm"
  machine_type              = var.machine_type_medium
  zone                      = var.zone
  allow_stopping_for_update = true
  depends_on = [ google_project_service.service, time_sleep.wait_for_services ]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = var.project


    access_config {
      nat_ip = google_compute_address.dev_gitlab_static_ip.address
    }
  }

  tags = ["gitlab"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/key.pub")}"
  }
  
  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}

