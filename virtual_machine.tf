resource "vsphere_virtual_machine" "vm" {
    name = "terraform-test"
    resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
    datastore_id     = "${data.vsphere_datastore.datastore.id}"
    num_cpus = 2
    memory = 1024
    guest_id = "centos7_64Guest"
        
    network_interface {
        network_id = "${data.vsphere_network.network.id}"
    }

    
    disk {
        label = "disk0"
        size  = 20
        thin_provisioned = false
    }

    clone {
        template_uuid = "${data.vsphere_virtual_machine.template.id}" 
        customize {
            linux_options {
                host_name = "elk-terraform-test"
                domain = "kbspro.local"
            }
            network_interface {
                ipv4_address = "172.30.111.202"
                ipv4_netmask = "24"
            }
            ipv4_gateway = "172.30.111.1"
            
        }   

    }
}

