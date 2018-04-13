resource "digitalocean_loadbalancer" "devops" {
  name   = "devops-lb2"
  region = "nyc1"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 3000
    target_protocol = "http"
  }

  healthcheck {
    port     = 3000
    protocol = "http"
    path     = "/"
  }

  droplet_tag = "${digitalocean_tag.devops.name}"
}

resource "digitalocean_tag" "devops" {
  name = "devops"
}

resource "digitalocean_droplet" "devops" {
  count    = 2
  image    = "${var.image_id}"
  name     = "devops"
  region   = "nyc1"
  size     = "512mb"
  ssh_keys = [19927153]
  tags     = ["${digitalocean_tag.devops.id}"]

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "sleep 160 && ${self.ipv4.address}:3000"
  }

  user_data = <<EOF
#cloud-config
coreos:
    units:
        - name: "devops.service"
          command: "start"
          content: |
            [Unit]
            Description=devops
            After=docker.service

            [Service]
            ExecStart=/usr/bin/docker run -d -p 3000:3000 devops
    EOF
}
