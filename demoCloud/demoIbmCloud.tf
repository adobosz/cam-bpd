#####################################################################
##
##      Created 3/19/19 by admin.
##
#####################################################################

## REFERENCE {"ibm_network":{"type": "ibm_reference_network"}}

terraform {
  required_version = "> 0.8.0"
}

provider "ibm" {
  bluemix_api_key    = "${var.ibm_bmx_api_key}"
  softlayer_username = "${var.ibm_sl_username}"
  softlayer_api_key  = "${var.ibm_sl_api_key}"
  version = "~> 0.7"
}

variable "ibm_bmx_api_key" {
  type = "string"
  description = "Generated"
}

variable "ibm_sl_username" {
  type = "string"
  description = "Generated"
}

variable "ibm_sl_api_key" {
  type = "string"
  description = "Generated"
}

variable "vm_instance1_domain" {
  type = "string"
  description = "The domain for the computing instance."
}

variable "vm_instance1_hostname" {
  type = "string"
  description = "The hostname for the computing instance."
}

variable "vm_instance1_datacenter" {
  type = "string"
  description = "The datacenter in which you want to provision the instance. NOTE: If dedicated_host_name or dedicated_host_id is provided then the datacenter should be same as the dedicated host datacenter."
}

variable "vm_instance1_os_reference_code" {
  type = "string"
  description = "Generated"
}

variable "ibm_ssh_key_name" {
  type = "string"
  description = "Generated"
}

variable "ibm_network_private_vlan_id" {
  type = "string"
  description = "Generated"
}


resource "ibm_compute_vm_instance" "vm_instance1" {
  cores       = 1
  memory      = 1024
  domain      = "${var.vm_instance1_domain}"
  hostname    = "${var.vm_instance1_hostname}"
  datacenter  = "${var.vm_instance1_datacenter}"
  ssh_key_ids = ["${ibm_compute_ssh_key.auth.id}"]
  os_reference_code = "${var.vm_instance1_os_reference_code}"
  private_vlan_id       = "${var.ibm_network_private_vlan_id}"
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "auth" {
  label = "${var.ibm_ssh_key_name}"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}