
terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.13"
}

provider "hcloud" {
  token = var.hcloud_token
}


variable "hcloud_token" {
  description = "Hetzner API Token"
  sensitive   = true
}

variable "num" {
  description = "Number of Servers"
  default     = 3
}
variable "ip_range" {
  description = "IP Range for internal network"
  default     = "10.0.1.0/24"
}

variable "ssh_pub_key_path" {
  description = "Path to the pub ssh key. Same key need to be used to upload using ansible"
}


resource "random_pet" "names" {
  count = var.num
}

### Servers
resource "hcloud_ssh_key" "default" {
  name       = "default"
  public_key = file(var.ssh_pub_key_path)
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.tpl")
  vars = {
    public_key = "${hcloud_ssh_key.default.public_key}"
  }
}
resource "hcloud_server" "server" {
  count       = var.num
  name        = "bejus ${random_pet.names[count.index].id}"
  server_type = "cx11"
  image       = "ubuntu-20.04"
  location    = "nbg1"
  labels = {
    type = "beju"
  }
  ssh_keys  = [hcloud_ssh_key.default.name]
  user_data = data.template_file.user_data.template
}

### load balancers
resource "hcloud_load_balancer" "web_lb" {
  name               = "beju_load_Balancer"
  load_balancer_type = "lb11"
  location           = "nbg1"
  labels = {
    type = "beju"
  }

  dynamic "target" {
    for_each = hcloud_server.server
    content {
      type      = "server"
      server_id = target.value["id"]
    }
  }

  algorithm {
    type = "round_robin"
  }
}

resource "hcloud_load_balancer_service" "web_lb_service" {
  load_balancer_id = hcloud_load_balancer.web_lb.id
  protocol         = "http"
  listen_port      = 80
  destination_port = 80

  health_check {
    protocol = "http"
    port     = 80
    interval = "10"
    timeout  = "10"
    http {
      path         = "/"
      status_codes = ["2??", "3??"]
    }
  }
}

resource "hcloud_load_balancer_network" "web_network" {
  load_balancer_id        = hcloud_load_balancer.web_lb.id
  subnet_id               = hcloud_network_subnet.hc_private_subnet.id
  enable_public_interface = "true"
}

### Network
resource "hcloud_network" "hc_private" {
  name     = "hc_private"
  ip_range = var.ip_range
}

resource "hcloud_server_network" "web_network" {
  count     = var.num
  server_id = hcloud_server.server[count.index].id
  subnet_id = hcloud_network_subnet.hc_private_subnet.id
}

resource "hcloud_network_subnet" "hc_private_subnet" {
  network_id   = hcloud_network.hc_private.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = var.ip_range
}

### Output
output "load_balancer_ip" {
  description = "Load balancer IP address"
  value       = hcloud_load_balancer.web_lb.ipv4
}

output "web_servers_status" {
  value = {
    for server in hcloud_server.server :
    server.name => server.status
  }
}

output "web_servers_ips" {
  description = "individual ips"
  value = {
    for server in hcloud_server.server :
    server.name => server.ipv4_address
  }
}

# Host file for ansible
resource "local_file" "hosts_file" {
  #https://www.bogotobogo.com/DevOps/Terraform/Terraform-Introduction-AWS-loops.php
  content  = join("\n", hcloud_server.server[*].ipv4_address)
  filename = "${path.module}/hosts"
}
