# variable "resource_group_name" {
#   description = "The name of the resource group in which the resources will be created."
#   type        = string
# }

# variable "location" {
#   description = "(Optional) The location in which the resources will be created."
#   type        = string
#   default     = ""
# }
# 
# variable "vnet_subnet_id" {
#   description = "The subnet id of the virtual network where the virtual machines will reside."
#   type        = string
# }

# variable "public_ip_dns" {
#   description = "Optional globally unique per datacenter region domain name label to apply to each public ip address. e.g. thisvar.varlocation.cloudapp.azure.com where you specify only thisvar here. This is an array of names which will pair up sequentially to the number of public ips defined in var.nb_public_ip. One name or empty string is required for every public ip. If no public ip is desired, then set this to an array with a single empty string."
#   type        = list(string)
#   default     = [null]
# }

# variable "admin_password" {
#   description = "The admin password to be used on the VMSS that will be deployed. The password must meet the complexity requirements of Azure."
#   type        = string
# }

# variable "extra_ssh_keys" {
#   description = "Same as ssh_key, but allows for setting multiple public keys. Set your first key in ssh_key, and the extras here."
#   type        = list(string)
#   default     = []
# }

# variable "ssh_key" {
#   description = "Path to the public key to be used for ssh access to the VM. Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub."
#   type        = string
#   default     = "~/.ssh/id_rsa.pub"
# }

# variable "ssh_key_values" {
#   description = "List of Public SSH Keys values to be used for ssh access to the VMs."
#   type        = list(string)
#   default     = []
# }
# variable "remote_port" {
#   description = "Remote tcp port to be used for access to the vms created via the nsg applied to the nics."
#   type        = string
#   default     = ""
# }

# variable "admin_username" {
#   description = "The admin username of the VM that will be deployed."
#   type        = string
#   default     = "azureuser"
# }

# variable "custom_data" {
#   description = "The custom data to supply to the machine. This can be used as a cloud-init for Linux systems."
#   type        = string
#   default     = ""
# }

# variable "vm_size" {
#   description = "Specifies the size of the virtual machine."
#   type        = string
#   default     = "Standard_D2s_v3"
# }

# variable "nb_instances" {
#   description = "Specify the number of vm instances."
#   type        = number
#   default     = 1
# }

# variable "nb_network_interfaces" {
#   description = "Specify the number of vm network interfaces."
#   type        = number
#   default     = 1
# }

# variable "network_interfaces" {
#   description = "Specify the number of vm network interfaces."
#   type        = any
#   default     = []
# }

# variable "vm_hostname" {
#   description = "local name of the Virtual Machine."
#   type        = string
# }

# variable "vm_os_simple" {
#   description = "Specify UbuntuServer, WindowsServer, RHEL, openSUSE-Leap, CentOS, Debian, CoreOS and SLES to get the latest image version of the specified os.  Do not provide this value if a custom value is used for vm_os_publisher, vm_os_offer, and vm_os_sku."
#   type        = string
#   default     = ""
# }

# variable "vm_os_id" {
#   description = "The resource ID of the image that you want to deploy if you are using a custom image.Note, need to provide is_windows_image = true for windows custom images."
#   type        = string
#   default     = ""
# }

# variable "is_windows_image" {
#   description = "Boolean flag to notify when the custom image is windows based."
#   type        = bool
#   default     = false
# }

# variable "vm_os_publisher" {
#   description = "The name of the publisher of the image that you want to deploy. Valid values - MicrosoftWindowsServer, RedHat"
#   type        = string
#   default     = null
# }

# variable "vm_os_offer" {
#   description = "The name of the offer of the image that you want to deploy. Valid values - WindowsServer, RHEL"
#   type        = string
#   default     = null
# }

# variable "vm_os_sku" {
#   description = "The sku of the image that you want to deploy. Valid values - 2019-Datacenter, 8-LVM"
#   type        = string
#   default     = null
# }

# variable "vm_os_version" {
#   description = "The version of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
#   type        = string
#   default     = "latest"
# }

# variable "tags" {
#   type        = map(string)
#   description = "A map of the tags to use on the resources that are deployed with this module."

#   default = {
#     source = "terraform"
#   }
# }

# variable "allocation_method" {
#   description = "Defines how an IP address is assigned. Options are Static or Dynamic."
#   type        = string
#   default     = "Static"
# }

# variable "public_ip_sku" {
#   description = "Defines the SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
#   type        = string
#   default     = "Basic"
# }

# variable "nb_public_ip" {
#   description = "Number of public IPs to assign corresponding to one IP per vm. Set to 0 to not assign any public IP addresses."
#   type        = number
#   default     = 0
# }

# variable "delete_os_disk_on_termination" {
#   type        = bool
#   description = "Delete datadisk when machine is terminated."
#   default     = false
# }

# variable "delete_data_disks_on_termination" {
#   type        = bool
#   description = "Delete data disks when machine is terminated."
#   default     = false
# }

# variable "data_sa_type" {
#   description = "Data Disk Storage Account type."
#   type        = string
#   default     = "Standard_LRS"
# }

# variable "data_disk_size_gb" {
#   description = "Storage data disk size size."
#   type        = number
#   default     = 30
# }

# variable "boot_diagnostics" {
#   type        = bool
#   description = "(Optional) Enable or Disable boot diagnostics."
#   default     = false
# }

# variable "boot_diagnostics_sa_type" {
#   description = "(Optional) Storage account type for boot diagnostics."
#   type        = string
#   default     = "Standard_LRS"
# }

# variable "storage_account_name" {
#   description = "(Optional) Storage account name for boot diagnostics."
#   type        = string
#   default     = ""
# }

# variable "enable_accelerated_networking" {
#   type        = bool
#   description = "(Optional) Enable accelerated networking on Network interface."
#   default     = false
# }

# variable "enable_ssh_key" {
#   type        = bool
#   description = "(Optional) Enable ssh key authentication in Linux virtual Machine."
#   default     = true
# }

# variable "nb_data_disk" {
#   description = "(Optional) Number of the data disks attached to each virtual machine."
#   type        = number
#   default     = 0
# }

# variable "source_address_prefixes" {
#   description = "(Optional) List of source address prefixes allowed to access var.remote_port."
#   type        = list(string)
#   default     = ["0.0.0.0/0"]
# }

# variable "license_type" {
#   description = "Specifies the BYOL Type for this Virtual Machine. This is only applicable to Windows Virtual Machines. Possible values are Windows_Client and Windows_Server"
#   type        = string
#   default     = null
# }

# variable "identity_type" {
#   description = "The Managed Service Identity Type of this Virtual Machine."
#   type        = string
#   default     = ""
# }

# variable "identity_ids" {
#   description = "Specifies a list of user managed identity ids to be assigned to the VM."
#   type        = list(string)
#   default     = []
# }

# variable "extra_disks" {
#   description = "(Optional) List of extra data disks attached to each virtual machine."
#   type        = list(object({
#     name = string
#     size = number
#   }))
#   default     = []
# }

# variable "os_profile_secrets" {
#   description = "Specifies a list of certificates to be installed on the VM, each list item is a map with the keys source_vault_id, certificate_url and certificate_store."
#   type        = list(map(string))
#   default     = []
# }

# variable "kv_secret_name" {
#   type        = string
#   description = "(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created."
#   default     = "azure-user-bootstrap"
# }

# variable "kv_name" {
#   type        = string
#   description = "(Required) Specifies the name of the Key Vault. Changing this forces a new resource to be created"
# }

# variable "kv_resource_group_name" {
#   type        = string
#   description = "(Required) The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created"
# }

# variable "os_disk_caching" {
#   type        = string
#   description = "(Optional) Specifies the caching requirements for the Data Disk. Possible values include None, ReadOnly and ReadWrite"
#   default     = "ReadWrite"
# }

# variable "data_disk_caching" {
#   type        = string
#   description = "(Optional) Specifies the caching requirements for the Data Disk. Possible values include None, ReadOnly and ReadWrite"
#   default     = "ReadWrite"
# }

# variable "custom_image" {
#   description = "(Optional) Specify the custom image plan like palonetworks etc"
#   type        = bool
#   default     = false
# }

# variable "override_av_name" {
#   description = "If custom name for avialability set is required"
#   type        = string
#   default     = null
# }

# variable "update_domain_count" {
#   description = "Number of faulr update domain count"
#   type        = number
#   default     = 2
# }

# variable "create_nsg" {
#   description = "Create NSG and attach to Network Interface "
#   type        = bool
#   default     = true
# }

# variable "create_managed_disk_from_vhd" {
#   description = "If managed disk needs to be created from vhd which will be used to create OS disk for VM"
#   type        = bool
#   default     = false
# }

# variable "storage_account_id" {
#   description = "Storage account which stores the vhd file"
#   type        = string
#   default     = null
# }

# variable "source_vhd_path" {
#   description = "Source VHD uri"
#   type        = string
#   default     = null
# }

# variable "managed_disk_size_gb" {
#   description = "Managed disk size in gb"
#   default     = null
# }

# variable "managed_disk_os_type" {
#   description = "Managed disk os type"
#   default     = null
# }

# variable "plan_info_required" {
#   description = "if information needs to be provided by consumer for plan block for custome linux image"
#   default     = true
#   type        = bool
# }