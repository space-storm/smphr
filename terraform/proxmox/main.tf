terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.99"
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
  vm_id     = var.vm_id

  clone {
    vm_id = var.template_vm_id
  }

  cpu {
    cores = var.cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.memory
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = var.bridge
    model  = "virtio"
  }

  disk {
    datastore_id = var.datastore
    interface    = "scsi0"
    size         = var.disk_size
    discard      = "on"
    iothread     = true
  }

  initialization {
    datastore_id = var.datastore

    user_account {
      username = var.ci_user
      keys     = [var.ssh_public_key]
    }

    dns {
      servers = var.dns_servers
    }

    ip_config {
      ipv4 {
        address = var.ip_address != "" ? "${var.ip_address}/24" : "dhcp"
        gateway = var.ip_address != "" ? var.gateway : null
      }
    }
  }

  operating_system {
    type = "l26"
  }

  on_boot = true
}
