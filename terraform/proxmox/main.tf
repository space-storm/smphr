terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.66"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = "${var.proxmox_api_token_id}=${var.proxmox_api_token_secret}"
  insecure  = var.pm_tls_insecure
}

resource "proxmox_virtual_environment_vm" "openclaw" {
  name      = var.vm_name
  node_name = var.proxmox_node

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  disk {
    datastore_id = var.datastore
    interface    = "scsi0"
    size         = 32
  }

  network_device {
    bridge = var.bridge
  }
}