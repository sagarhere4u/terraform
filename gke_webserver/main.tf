variable "json_file" {
}

variable "project" {
}

provider "google" {
  credentials = file(var.json_file)
  project = var.project
  region  = "asia-south1"
  zone    = "asia-south1-a"
}

resource "google_compute_firewall" "firewall" {
  name    = "sample-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["foo"]
}

resource "google_compute_instance" "sample" {
  name = "sample"
  machine_type = "e2-micro"

  tags = ["foo"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2404-lts-amd64"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "adminuser:${file("~/.ssh/id_rsa.pub")}"
  }

  metadata_startup_script =  file("./web.sh")
}

output "Public-IP" {
  value = google_compute_instance.sample.network_interface[0].access_config[0].nat_ip
}