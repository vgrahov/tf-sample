data "vsphere_datacenter" "dc" {
    name = "HQ"
#    datacenter_id = "datacenter-21"
}

data "vsphere_compute_cluster" "compute_cluster" {
    name            = "Main Cluster"
    datacenter_id   = "${data.vsphere_datacenter.dc.id}"
}


data "vsphere_resource_pool" "pool" {
    name = "/${data.vsphere_datacenter.dc.name}/host/${data.vsphere_compute_cluster.compute_cluster.name}/Resources/${var.vsphere_resourse_pool}"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
    #group-v456
}

data "vsphere_network" "network" {
  name          = "1801 ERC_DEBUG_EXT"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "datastore" {
        name          = "Main Datastore"
        datacenter_id = "${data.vsphere_datacenter.dc.id}"
} 

data "vsphere_virtual_machine" "template" {
        name          = "template-Centos7"
        datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
