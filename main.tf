resource "google_compute_instance" "deployment" {
  project                   = var.project
  name                      = "dev-deployment-vm"
  machine_type              = "e2-standard-2"
  zone                      = var.zone
  allow_stopping_for_update = true
  depends_on                = [google_project_service.service, time_sleep.wait_for_services]

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
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/keys.pub")}"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}

resource "google_compute_instance" "database-jenkins" {
  project                   = var.project
  name                      = "dev-database-jenkins-vm"
  machine_type              = "e2-medium"
  zone                      = var.zone
  allow_stopping_for_update = true
  depends_on                = [google_project_service.service, time_sleep.wait_for_services]

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
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/keys.pub")}"
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
  name                      = "dev-staging-building-vm"
  machine_type              = "e2-medium"
  zone                      = var.zone
  allow_stopping_for_update = true
  depends_on                = [google_project_service.service, time_sleep.wait_for_services]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 60
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
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/keys.pub")}"
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
  machine_type              = "e2-standard-4"
  zone                      = var.zone
  allow_stopping_for_update = true
  depends_on                = [google_project_service.service, time_sleep.wait_for_services]

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
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/keys.pub")}"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}

###################### SIDE PROJECT ##################################
resource "google_compute_instance" "k8s-master" {
  project                   = var.project
  name                      = "k8s-master"
  machine_type              = var.machine_type_medium
  zone                      = "europe-north1-c"
  allow_stopping_for_update = true
  depends_on                = [google_project_service.service, time_sleep.wait_for_services]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts"
      size  = 30
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = var.project


    access_config {
      nat_ip = google_compute_address.k8s_master_static_ip.address
    }
  }

  tags = ["k8s"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/keys.pub")}"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}
resource "google_compute_instance" "k8s-node1" {
  project                   = var.project
  name                      = "k8s-node1"
  machine_type              = var.machine_type_small
  zone                      = "europe-north1-c"
  allow_stopping_for_update = true
  depends_on                = [google_project_service.service, time_sleep.wait_for_services]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts"
      size  = 20
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = var.project


    access_config {
      nat_ip = google_compute_address.k8s_node1_static_ip.address
    }
  }

  tags = ["k8s"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/keys.pub")}"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}
resource "google_compute_instance" "k8s-node2" {
  project                   = var.project
  name                      = "k8s-node2"
  machine_type              = var.machine_type_small
  zone                      = "europe-north1-c"
  allow_stopping_for_update = true
  depends_on                = [google_project_service.service, time_sleep.wait_for_services]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts"
      size  = 20
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = var.project


    access_config {
      nat_ip = google_compute_address.k8s_node2_static_ip.address
    }
  }

  tags = ["k8s"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/keys.pub")}"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}
resource "google_compute_instance" "k8s-node3" {
  project                   = var.project
  name                      = "k8s-node3"
  machine_type              = var.machine_type_small
  zone                      = "europe-north1-c"
  allow_stopping_for_update = true
  depends_on                = [google_project_service.service, time_sleep.wait_for_services]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts"
      size  = 20
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = var.project


    access_config {
      nat_ip = google_compute_address.k8s_node3_static_ip.address
    }
  }

  tags = ["k8s"]

  # metadata_startup_script = file("${path.module}/app-script/initial-script.sh")

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${path.module}/ssh-keys/keys.pub")}"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}