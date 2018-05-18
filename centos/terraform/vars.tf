variable "hyperv_hostname" {
  description = "Hyper-V hostname"
}

variable "hyperv_username" {
  description = "Hyper-V username"
}

variable "hyperv_password" {
  description = "Hyper-V password"
}

variable "hyperv_path" {
  description = "Hyper-V root folder to store VMs"
  default     = "C:\\ClusterStorage\\VMs"
}

variable "hyperv_switch" {
  description = "Hyper-V switch name"
  default     = "LAN"
}

variable "vm_nameprefix" {
  description = "Virtual machine name and hostname"
  default     = "centos"
}

variable "vm_quantity" {
  description = "Number of virtual machines"
  default     = "1"
}

variable "vm_ram" {
  description = "VM ram"
  default     = "2048"
}
