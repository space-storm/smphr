variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "pm_tls_insecure" {
  type    = bool
  default = true
}

variable "proxmox_node" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_id" {
  type = number
}

variable "template_vm_id" {
  type    = number
  default = 9002
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 4096
}

variable "bridge" {
  type    = string
  default = "vmbr0"
}

variable "datastore" {
  type    = string
  default = "local-zfs"
}

variable "disk_size" {
  type    = number
  default = 32
}

variable "ci_user" {
  type    = string
  default = "debian"
}

variable "ssh_public_key" {
  type = string
}

variable "ip_address" {
  type    = string
  default = ""
}

variable "gateway" {
  type    = string
  default = ""
}

variable "dns_servers" {
  type    = list(string)
  default = ["1.1.1.1", "8.8.8.8"]
}
