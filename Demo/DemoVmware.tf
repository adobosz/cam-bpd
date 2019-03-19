#####################################################################
##
##      Created 3/19/19 by admin.
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

provider "vsphere" {
  user           = "${var.user}"
  password       = "${var.password}"
  vsphere_server = "${var.vsphere_server}"

  allow_unverified_ssl = "${var.allow_unverified_ssl}"
  version = "~> 1.2"
}

variable "user" {
  type = "string"
  description = "Generated"
}

variable "password" {
  type = "string"
  description = "Generated"
}

variable "vsphere_server" {
  type = "string"
  description = "Generated"
}

variable "allow_unverified_ssl" {
  type = "string"
  description = "Generated"
}

variable "virtual_machine1_name" {
  type = "string"
  description = "Virtual machine name for virtual_machine1"
}

variable "virtual_machine1_number_of_vcpu" {
  type = "string"
  description = "Number of virtual cpu's."
}

variable "virtual_machine1_memory" {
  type = "string"
  description = "Memory allocation."
}

variable "virtual_machine1_disk_name" {
  type = "string"
  description = "The name of the disk. Forces a new disk if changed. This should only be a longer path if attaching an external disk."
}

variable "virtual_machine1_disk_size" {
  type = "string"
  description = "The size of the disk, in GiB."
}

variable "virtual_machine1_template_name" {
  type = "string"
  description = "Generated"
}

variable "virtual_machine1_datacenter_name" {
  type = "string"
  description = "Generated"
}

variable "virtual_machine1_datastore_name" {
  type = "string"
  description = "Generated"
}

variable "virtual_machine1_resource_pool" {
  type = "string"
  description = "Resource pool."
}

data "vsphere_virtual_machine" "virtual_machine1_template" {
  name          = "${var.virtual_machine1_template_name}"
  datacenter_id = "${data.vsphere_datacenter.virtual_machine1_datacenter.id}"
}

data "vsphere_datacenter" "virtual_machine1_datacenter" {
  name = "${var.virtual_machine1_datacenter_name}"
}

data "vsphere_datastore" "virtual_machine1_datastore" {
  name          = "${var.virtual_machine1_datastore_name}"
  datacenter_id = "${data.vsphere_datacenter.virtual_machine1_datacenter.id}"
}

resource "vsphere_virtual_machine" "virtual_machine1" {
  name          = "${var.virtual_machine1_name}"
  datastore_id  = "${data.vsphere_datastore.virtual_machine1_datastore.id}"
  num_cpus      = "${var.virtual_machine1_number_of_vcpu}"
  memory        = "${var.virtual_machine1_memory}"
  guest_id = "${data.vsphere_virtual_machine.virtual_machine1_template.guest_id}"
  resource_pool_id = "${var.virtual_machine1_resource_pool}"
  clone {
    template_uuid = "${data.vsphere_virtual_machine.virtual_machine1_template.id}"
  }
  disk {
    name = "${var.virtual_machine1_disk_name}"
    size = "${var.virtual_machine1_disk_size}"
  }
}

