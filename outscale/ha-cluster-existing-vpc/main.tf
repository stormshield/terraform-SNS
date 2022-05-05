terraform {
  required_providers {
    outscale = {
      source  = "outscale-dev/outscale"
      version = "0.5.2"
    }
  }
}

variable "project_name" {}
variable "access_key_id" {}
variable "secret_key_id" {}
variable "region" {}
variable "zone" {}
variable "vpc_id" {}
variable "public_subnet_id" {}
variable "hasync_subnet_id" {}
variable "private_subnet_id" {}
variable "gateway_ip" {}
variable "eva1_public_ip" {}
variable "eva1_sync_ip" {}
variable "eva1_private_ip" {}
variable "eva2_public_ip" {}
variable "eva2_sync_ip" {}
variable "eva2_private_ip" {}
variable "eva_omi" {}
variable "eva_vm_type" {}
variable "ubuntu_omi" {}
variable "ubuntu_vm_type" {}
variable "keypair" {}
variable "eva_mask" {}
variable "eva_password" {}

provider "outscale" {
  access_key_id = var.access_key_id
  secret_key_id = var.secret_key_id
  region        = var.region
}



/*
 * outputs
 */

output "eva1_cluster_public_ip" {
  value = outscale_public_ip.eip_ha.public_ip
}

output "eva2_temp_public_ip" {
  value = outscale_public_ip.eip_eva2.public_ip
}

