## Creates resource group
resource "azurerm_resource_group" "rg-cci-poc-dev2" {
  name     = "rg-cci-poc-dev2"
  location = "East US2"

  tags = {
    "owner"  = "Pink Rathod",
  }
}

# locals {
#   _network_interfaces = flatten([
#     for vm_key, vm in range(var.nb_instances) : [
#       for nwi_key, network_interfaces in var.network_interfaces : {
#         interface_key  = nwi_key + 1
#         interface_name = "${var.vm_hostname}-${vm_key + 1}-${network_interfaces.subnet_name}"
#         vnet_subnet_id = network_interfaces.vnet_subnet_id
#       }
#     ]
#   ])

#   _vm_nics = chunklist(values(azurerm_network_interface.vm_different_vnet_subnet).*.id, length(var.network_interfaces))
# }

# module "os" {
#   source       =  "./modules/os"
#   vm_os_simple = var.vm_os_simple
# }

# locals {
#   ssh_keys = compact(concat([var.ssh_key], var.extra_ssh_keys))
# }

# resource "random_id" "vm-sa" {
#   keepers = {
#     vm_hostname = var.vm_hostname
#   }

#   byte_length = 6
# }

# resource "azurerm_virtual_machine" "vm-linux" {
#   count = !contains(tolist([
#     var.vm_os_simple, var.vm_os_offer
#   ]), "WindowsServer") && !var.is_windows_image ? (var.create_availability_set ? var.nb_instances : 1) : 0
#   name                             = var.create_availability_set ? "${var.vm_hostname}${format("%02d", count.index + 1)}" : var.vm_hostname
#   resource_group_name              = var.resource_group_name
#   location                         = var.location
#   availability_set_id              = var.create_availability_set ? azurerm_availability_set.vm[0].id : null
#   vm_size                          = var.vm_size
#   primary_network_interface_id     = length(var.network_interfaces) > 0 ? element(element(local._vm_nics.*, count.index), count.index) : element(azurerm_network_interface.vm_same_vnet_subnet.*.id, count.index)
#   network_interface_ids            = length(var.network_interfaces) > 0 ? element(local._vm_nics.*, count.index) : [azurerm_network_interface.vm_same_vnet_subnet[count.index].id]
#   delete_os_disk_on_termination    = var.delete_os_disk_on_termination
#   delete_data_disks_on_termination = var.delete_data_disks_on_termination

#   dynamic "plan" {
#     for_each = var.custom_image == true && var.vm_os_id == "" && var.plan_info_required == true ? [1] : []
#     content {
#       name      = var.vm_os_sku
#       product   = var.vm_os_offer
#       publisher = var.vm_os_publisher
#     }
#   }

#   dynamic "identity" {
#     for_each = length(var.identity_ids) == 0 && var.identity_type == "SystemAssigned" ? [var.identity_type] : []
#     content {
#       type = var.identity_type
#     }
#   }

#   dynamic "identity" {
#     for_each = length(var.identity_ids) > 0 || var.identity_type == "UserAssigned" ? [var.identity_type] : []
#     content {
#       type         = var.identity_type
#       identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : []
#     }
#   }

#   dynamic "storage_image_reference" {
#     for_each = var.create_managed_disk_from_vhd == true && var.managed_disk_os_type == "Linux" ? [] : [1]
#     content {
#       id        = var.vm_os_id
#       publisher = var.vm_os_id == "" ? coalesce(var.vm_os_publisher, module.os.calculated_value_os_publisher) : ""
#       offer     = var.vm_os_id == "" ? coalesce(var.vm_os_offer, module.os.calculated_value_os_offer) : ""
#       sku       = var.vm_os_id == "" ? coalesce(var.vm_os_sku, module.os.calculated_value_os_sku) : ""
#       version   = var.vm_os_id == "" ? var.vm_os_version : ""
#     }
#   }

#   storage_os_disk {
#     name              = var.create_availability_set ? "${var.vm_hostname}-osdisk-${count.index + 1}" : "${var.vm_hostname}-OSDISK"
#     create_option     = var.create_managed_disk_from_vhd && var.managed_disk_os_type == "Linux" ? "Attach" : "FromImage"
#     caching           = var.os_disk_caching
#     managed_disk_type = var.storage_account_type
#     os_type           = var.managed_disk_os_type
#     managed_disk_id   = var.create_managed_disk_from_vhd && var.managed_disk_os_type == "Linux" ? azurerm_managed_disk.custom_vhd[0].id : null
#   }

#   dynamic "storage_data_disk" {
#     for_each = range(var.nb_data_disk)
#     content {
#       name              = var.create_availability_set ? "${var.vm_hostname}-datadisk-${count.index + 1}-${storage_data_disk.value}" : "${var.vm_hostname}-datadisk-${storage_data_disk.value}"
#       create_option     = "Empty"
#       lun               = storage_data_disk.value
#       disk_size_gb      = var.data_disk_size_gb
#       managed_disk_type = var.data_sa_type
#       caching           = var.data_disk_caching
#     }
#   }

#   dynamic "storage_data_disk" {
#     for_each = var.extra_disks
#     content {
#       name              = var.create_availability_set ? "${var.vm_hostname}-extradisk-${count.index + 1}-${storage_data_disk.value.name}" : "${var.vm_hostname}-extradisk-${storage_data_disk.value.name}"
#       create_option     = "Empty"
#       lun               = storage_data_disk.key + var.nb_data_disk
#       disk_size_gb      = storage_data_disk.value.size
#       managed_disk_type = var.data_sa_type
#       caching           = var.data_disk_caching
#     }
#   }

#   dynamic "os_profile" {
#     for_each = var.create_managed_disk_from_vhd == true && var.managed_disk_os_type == "Linux" ? [] : [1]
#     content {
#       computer_name  = var.create_availability_set ? "${var.vm_hostname}${format("%02d", count.index + 1)}" : var.vm_hostname
#       admin_username = var.admin_username
#       admin_password = var.admin_password
#       custom_data    = var.custom_data
#     }
#   }

#   os_profile_linux_config {
#     disable_password_authentication = var.enable_ssh_key

#     dynamic "ssh_keys" {
#       for_each = var.enable_ssh_key ? local.ssh_keys : []
#       content {
#         path     = "/home/${var.admin_username}/.ssh/authorized_keys"
#         key_data = file(ssh_keys.value)
#       }
#     }

#     dynamic "ssh_keys" {
#       for_each = var.enable_ssh_key ? var.ssh_key_values : []
#       content {
#         path     = "/home/${var.admin_username}/.ssh/authorized_keys"
#         key_data = ssh_keys.value
#       }
#     }

#   }

#   dynamic "os_profile_secrets" {
#     for_each = var.os_profile_secrets
#     content {
#       source_vault_id = os_profile_secrets.value["source_vault_id"]

#       vault_certificates {
#         certificate_url = os_profile_secrets.value["certificate_url"]
#       }
#     }
#   }

#   tags = var.tags

#   boot_diagnostics {
#     enabled     = var.boot_diagnostics
#     storage_uri = var.boot_diagnostics ? join(",", azurerm_storage_account.vm-sa.*.primary_blob_endpoint) : ""
#   }

#   lifecycle {
#     ignore_changes = [
#       identity, os_profile, name, boot_diagnostics, storage_os_disk, storage_data_disk, network_interface_ids,
#       primary_network_interface_id
#     ]
#   }
# }

# resource "azurerm_virtual_machine" "vm-windows" {
#   count = (var.is_windows_image || contains(tolist([
#     var.vm_os_simple, var.vm_os_offer
#   ]), "WindowsServer")) ? (var.create_availability_set ? var.nb_instances : 1) : 0
#   name                          = var.create_availability_set ? "${var.vm_hostname}${format("%02d", count.index + 1)}" : var.vm_hostname
#   resource_group_name           = var.resource_group_name
#   location                      = var.location
#   availability_set_id           = var.create_availability_set ? azurerm_availability_set.vm[0].id : null
#   vm_size                       = var.vm_size
#   primary_network_interface_id  = length(var.network_interfaces) > 0 ? element(element(local._vm_nics.*, count.index), count.index) : element(azurerm_network_interface.vm_same_vnet_subnet.*.id, count.index)
#   network_interface_ids         = length(var.network_interfaces) > 0 ? element(local._vm_nics.*, count.index) : [azurerm_network_interface.vm_same_vnet_subnet[count.index].id]
#   delete_os_disk_on_termination = var.delete_os_disk_on_termination
#   license_type                  = var.license_type

#   dynamic "identity" {
#     for_each = length(var.identity_ids) == 0 && var.identity_type == "SystemAssigned" ? [var.identity_type] : []
#     content {
#       type = var.identity_type
#     }
#   }

#   dynamic "identity" {
#     for_each = length(var.identity_ids) > 0 || var.identity_type == "UserAssigned" ? [var.identity_type] : []
#     content {
#       type         = var.identity_type
#       identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : []
#     }
#   }

#   dynamic "storage_image_reference" {
#     for_each = var.create_managed_disk_from_vhd == true && var.managed_disk_os_type == "Windows" ? [] : [1]
#     content {
#       id        = var.vm_os_id
#       publisher = var.vm_os_id == "" ? coalesce(var.vm_os_publisher, module.os.calculated_value_os_publisher) : ""
#       offer     = var.vm_os_id == "" ? coalesce(var.vm_os_offer, module.os.calculated_value_os_offer) : ""
#       sku       = var.vm_os_id == "" ? coalesce(var.vm_os_sku, module.os.calculated_value_os_sku) : ""
#       version   = var.vm_os_id == "" ? var.vm_os_version : ""
#     }
#   }

#   storage_os_disk {
#     name              = var.create_availability_set ? "${var.vm_hostname}-osdisk-${count.index + 1}" : "${var.vm_hostname}-OSDISK"
#     create_option     = var.create_managed_disk_from_vhd && var.managed_disk_os_type == "Windows" ? "Attach" : "FromImage"
#     caching           = var.os_disk_caching
#     os_type           = var.managed_disk_os_type
#     managed_disk_type = var.storage_account_type
#     managed_disk_id   = var.create_managed_disk_from_vhd && var.managed_disk_os_type == "Windows" ? azurerm_managed_disk.custom_vhd[0].id : null
#   }

#   dynamic "storage_data_disk" {
#     for_each = range(var.nb_data_disk)
#     content {
#       name              = var.create_availability_set ? "${var.vm_hostname}-datadisk-${count.index + 1}-${storage_data_disk.value}" : "${var.vm_hostname}-datadisk-${storage_data_disk.value}"
#       create_option     = "Empty"
#       lun               = storage_data_disk.value
#       disk_size_gb      = var.data_disk_size_gb
#       managed_disk_type = var.data_sa_type
#       caching           = var.data_disk_caching
#     }
#   }

#   dynamic "storage_data_disk" {
#     for_each = var.extra_disks
#     content {
#       name              = var.create_availability_set ? "${var.vm_hostname}-extradisk-${count.index + 1}-${storage_data_disk.value.name}" : "${var.vm_hostname}-extradisk-${storage_data_disk.value.name}"
#       create_option     = "Empty"
#       lun               = storage_data_disk.key + var.nb_data_disk
#       disk_size_gb      = storage_data_disk.value.size
#       managed_disk_type = var.data_sa_type
#       caching           = var.data_disk_caching
#     }
#   }

#   dynamic "os_profile" {
#     for_each = var.create_managed_disk_from_vhd == true && var.managed_disk_os_type == "Windows" ? [] : [1]
#     content {
#       computer_name  = var.create_availability_set ? "${var.vm_hostname}${format("%02d", count.index + 1)}" : var.vm_hostname
#       admin_username = var.admin_username
#       admin_password = var.admin_password
#     }
#   }

#   tags = var.tags

#   os_profile_windows_config {
#     provision_vm_agent = true
#   }

#   dynamic "os_profile_secrets" {
#     for_each = var.os_profile_secrets
#     content {
#       source_vault_id = os_profile_secrets.value["source_vault_id"]

#       vault_certificates {
#         certificate_url   = os_profile_secrets.value["certificate_url"]
#         certificate_store = os_profile_secrets.value["certificate_store"]
#       }
#     }
#   }

#   boot_diagnostics {
#     enabled     = var.boot_diagnostics
#     storage_uri = var.boot_diagnostics ? join(",", azurerm_storage_account.vm-sa.*.primary_blob_endpoint) : ""
#   }

#   lifecycle {
#     ignore_changes = [identity]
#   }
# }

# resource "azurerm_network_security_group" "vm" {
#   count               = var.create_nsg ? 1 : 0
#   name                = "${var.vm_hostname}-nsg"
#   resource_group_name = var.resource_group_name
#   location            = var.location

#   tags = var.tags
# }

# resource "azurerm_network_security_rule" "vm" {
#   count                       = var.remote_port != "" && var.create_nsg ? 1 : 0
#   name                        = "allow_remote_${coalesce(var.remote_port, module.os.calculated_remote_port)}_in_all"
#   resource_group_name         = var.resource_group_name
#   description                 = "Allow remote protocol in from all locations"
#   priority                    = 101
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = coalesce(var.remote_port, module.os.calculated_remote_port)
#   source_address_prefixes     = var.source_address_prefixes
#   destination_address_prefix  = "*"
#   network_security_group_name = azurerm_network_security_group.vm[0].name
# }

# resource "azurerm_network_interface" "vm_same_vnet_subnet" {
#   count                         = length(var.network_interfaces) > 0 ? 0 : var.nb_network_interfaces
#   name                          = "${var.vm_hostname}-nic-${count.index}"
#   resource_group_name           = var.resource_group_name
#   location                      = var.location
#   enable_accelerated_networking = var.enable_accelerated_networking

#   ip_configuration {
#     name                          = "${var.vm_hostname}-ip-${count.index}"
#     subnet_id                     = var.vnet_subnet_id
#     private_ip_address_allocation = "Dynamic"
#   }

#   tags = var.tags
# }

# resource "azurerm_network_interface" "vm_different_vnet_subnet" {
#   for_each                      = { for index, nw in local._network_interfaces : nw.interface_name => nw }
#   name                          = "${each.value.interface_name}-nic-${each.value.interface_key}"
#   resource_group_name           = lookup(each.value, "resource_group_name", var.resource_group_name)
#   location                      = lookup(each.value, "location", var.location)
#   enable_accelerated_networking = lookup(each.value, "enable_accelerated_networking", var.enable_accelerated_networking)

#   ip_configuration {
#     name                          = "${each.value.interface_name}-ip-${each.value.interface_key}"
#     subnet_id                     = lookup(each.value, "vnet_subnet_id", var.vnet_subnet_id)
#     private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")
#   }

#   tags = var.tags

#   lifecycle {
#     ignore_changes        = [name, ip_configuration, enable_ip_forwarding]
#     create_before_destroy = true
#   }
# }

# resource "azurerm_network_interface_security_group_association" "vm_same_vnet_subnet" {
#   count                     = length(var.network_interfaces) > 0 || var.create_nsg == false ? 0 : var.nb_network_interfaces
#   network_interface_id      = azurerm_network_interface.vm_same_vnet_subnet[count.index].id
#   network_security_group_id = azurerm_network_security_group.vm[0].id
# }

# resource "azurerm_network_interface_security_group_association" "vm_different_vnet_subnet" {
#   for_each                  = { for index, nw in local._network_interfaces : nw.interface_name => nw if var.create_nsg }
#   network_interface_id      = azurerm_network_interface.vm_different_vnet_subnet[each.key].id
#   network_security_group_id = azurerm_network_security_group.vm[0].id
# }


# resource "azurerm_managed_disk" "custom_vhd" {
#   count                = var.create_managed_disk_from_vhd ? 1 : 0
#   name                 = "${var.vm_hostname}-custom-vhd-osdisk"
#   location             = var.location
#   resource_group_name  = var.resource_group_name
#   storage_account_type = var.storage_account_type
#   storage_account_id   = var.storage_account_id
#   os_type              = var.managed_disk_os_type
#   create_option        = "Import"
#   source_uri           = var.source_vhd_path
#   disk_size_gb         = var.managed_disk_size_gb
# }