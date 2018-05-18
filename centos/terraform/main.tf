provider "hyperv" {
  hypervisor = "${var.hyperv_hostname}"
  username   = "${var.hyperv_username}"
  password   = "${var.hyperv_password}"
}

### PREREQ
# terraform import hyperv_virtual_switch.application_switch 7b6e59d2-7c14-426b-a19f-6cc6a3f29d3b

# resource "hyperv_virtual_switch" "application_switch" {
#   name = "LAN"
#   type = "External"
# }

### PREREQ
# https://blogs.technet.microsoft.com/jhoward/2008/03/28/part-1-hyper-v-remote-management-you-do-not-have-the-required-permission-to-complete-this-task-contact-the-administrator-of-the-authorization-policy-for-the-computer-computername/
resource "hyperv_virtual_machine" "centos1" {
  count                = "${var.vm_quantity}"
  name                 = "${var.vm_nameprefix}${count.index}"
  processors           = "2"
  generation           = "1"
  ram                  = "8192"
  switch               = "${var.hyperv_switch}"
  disable_network_boot = false
  path                 = "${var.hyperv_path}"

  wait_for_ip {
    timeout      = 1
    adapter_name = "Scheda di rete"
  }

  storage_disk {
    name             = "boot"
    diff_parent_path = "${var.hyperv_path}\\VHDs\\packer-centos.vhdx"
  }

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname ${var.vm_nameprefix}${count.index}",
      "echo '127.0.0.1 ${var.vm_nameprefix}${count.index}' | sudo tee -a /etc/hosts",
    ]

    connection {
      type     = "ssh"
      user     = "centos"
      password = "centos"
      timeout  = "1m"
    }
  }
}
