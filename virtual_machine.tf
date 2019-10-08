

resource "vsphere_virtual_machine" "vm" {
    name = "node${count.index+1}"
    count= "4"
    resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
    datastore_id     = "${data.vsphere_datastore.datastore.id}"
    num_cpus = 2
    memory = 4096
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
                host_name = "node${count.index+1}"
                domain = "kbspro.local"
            }
            network_interface {
                ipv4_address = "172.30.111.${201 + count.index}"
                ipv4_netmask = "24"
                dns_domain = "kbspro.local"
            }
            ipv4_gateway = "172.30.111.1"
            dns_server_list = ["172.30.101.2"]
            
        }   

    }

    
}

resource "null_resource" "ansible_provisioning" {
    provisioner "local-exec" {
	    command = <<EOT
        ansible-playbook -i ansible/debug_deploy ansible/main.yml -T 100
        EOT
    }
    depends_on = [vsphere_virtual_machine.vm] 
}  




