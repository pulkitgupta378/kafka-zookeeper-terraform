resource "google_compute_instance" "kafka" {
    name = "kafka-zk"
    machine_type = "f1-micro"

    tags = ["buildserver", "jenkins", "central", "terraformer"]
    tags = [ "http-server" ]

    zone = "us-central1-b"

     boot_disk {
    initialize_params {
      image = "ubuntu-1404-trusty-v20180222a"
    }
  }

    network_interface {
        network = "default"
        access_config {}
    }

 metadata {
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_public_key_file)}"
  }


    provisioner "file" {
        source = "installations.sh"
        destination = "installations.sh"
        connection {
            type = "ssh"
            user  = "${var.gce_ssh_user}"
            private_key = "${file(var.gce_ssh_private_key_file)}"
            agent  = false
            timeout  = "90s"

                  }
          }


    provisioner "remote-exec" {
        inline = [
          "chmod +x ~/installations.sh",
          "cd ~",
          "./installations.sh"
        ]
        connection {
            type = "ssh"
            user = "${var.gce_ssh_user}"
            private_key = "${file(var.gce_ssh_private_key_file)}"
            agent = false
            timeout = "90s"
                   }

            }

    service_account {
        scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    }
}
