

env               = "nte"
region            = "westus2"
provider_selector = "Sandbox" 
subid             = "aec38400-fa45-4a32-8591-6b110c614bca"



resource_groups = [
  {
    location = "westus2"
    name     = "NTE"
    tags = {
      business-unit = "IT - Software Engineering"
      cost-center   = "5510 (IT - IT Services)"
      created-by    = "Slalom"
      environment   = "NTE"
      managed-by    = "adam.schaible@consumercellular.com"
    }
  }
]

virtual_networks = [
  {
    
    address_space       = ["10.104.32.0/19"]
    location            = "westus2"
    name                = "spoke"
    resource_group_name = "nte"
    dns_servers = [
      "10.0.3.1",
      "10.0.3.4",
      "10.0.2.254"
    ]
    tags = {
      created-by = "Slalom"
    }
    subnets = [
      {
        
        address_prefixes     = ["10.104.32.0/23"]
        name                 = "snet-vms"
        resource_group_name  = "nte"
        virtual_network_name = "spoke"
        delegate             = false 
        
        
        
      }
    ]
    route_tables = [
      {
        
        location            = "westus2"
        name                = "spoke"
        resource_group_name = "nte"
        tags = {
          created-by = "Slalom"
        }
        routes = [
          {
            
            address_prefix         = "10.104.96.0/23"
            name                   = "QA2Dev-test"
            next_hop_in_ip_address = "10.103.0.7"
            next_hop_type          = "VirtualAppliance"
            resource_group_name    = "nte"
            route_table_name       = "spoke"
            
            
            
          },
          {
            
            address_prefix         = "10.104.0.0/16"
            name                   = "SpokesToFirewall"
            next_hop_in_ip_address = "10.103.0.4"
            next_hop_type          = "VirtualAppliance"
            resource_group_name    = "nte"
            route_table_name       = "spoke"
            
            
            
          }
        ] 
      }
    ] 
  }
] 

windows_virtual_machine = [
  {
    
    location              = "westus2"
    name                  = "BLOG"
    network_interface_ids = ["/subscriptions/08432298-55d9-4320-93b4-a3a139be7fda/resourceGroups/rg-blog-qa/providers/Microsoft.Network/networkInterfaces/nic-blog1-00"]
    resource_group_name   = "nte"
    tags = {
      created-by   = "Slalom"
      created-date = "2022-07-22T22:53:48.1732383Z"
      os           = "Windows (Windows Server 2012 R2 Standard)"
    }
    vm_size = "Standard_DS3_v2" 
    boot_diagnostics = {
      enabled     = true
      storage_uri = ""
    }
    storage_os_disk = {
      create_option = "Attach"
      name          = "blog1-OSdisk"
    }
    
    
    
    network_interfaces = [
      {
        
        location            = "westus2"
        name                = "nic-blog1-00"
        resource_group_name = "nte"
        tags = {
          created-by = "Slalom"
        }
        ip_configuration = {
          name                          = "ipconfig1"
          private_ip_address_allocation = "Static"
          subnet_id                     = "/subscriptions/08432298-55d9-4320-93b4-a3a139be7fda/resourceGroups/cci-spoke-vnet-qa-westus2-rg/providers/Microsoft.Network/virtualNetworks/cci-spoke-vnet-qa-westus2-vnet/subnets/qa-1"
        }
      }
    ]
    virtual_machine_extensions = [
      /* 
      {
        
        auto_upgrade_minor_version = true
        name                       = "MDE.Windows"
        publisher                  = "Microsoft.Azure.AzureDefenderForServers"
        
        settings = jsonencode({
          autoUpdate        = true
          azureResourceId   = "/subscriptions/08432298-55d9-4320-93b4-a3a139be7fda/resourceGroups/RG-BLOG-QA/providers/Microsoft.Compute/virtualMachines/blog1"
          forceReOnboarding = false
          vNextEnabled      = true
        })
        tags = {
          created-by = "Slalom"
        }
        type                 = "MDE.Windows"
        type_handler_version = "1.0"
        virtual_machine_id   = "/subscriptions/08432298-55d9-4320-93b4-a3a139be7fda/resourceGroups/RG-BLOG-QA/providers/Microsoft.Compute/virtualMachines/blog1"
        
        
        
      },
 */
      {
        
        auto_upgrade_minor_version = true
        name                       = "AzureMonitorWindowsAgent"
        publisher                  = "Microsoft.Azure.Monitor"
        tags = {
          created-by = "Slalom"
        }
        type                 = "AzureMonitorWindowsAgent"
        type_handler_version = "1.0"
        virtual_machine_id   = "/subscriptions/08432298-55d9-4320-93b4-a3a139be7fda/resourceGroups/rg-blog-qa/providers/Microsoft.Compute/virtualMachines/blog1"
        
        
        
      },
      {
        
        auto_upgrade_minor_version = true
        name                       = "BGInfo"
        publisher                  = "Microsoft.Compute"
        tags = {
          created-by = "Slalom"
        }
        type                 = "BGInfo"
        type_handler_version = "2.2"
        virtual_machine_id   = "/subscriptions/08432298-55d9-4320-93b4-a3a139be7fda/resourceGroups/rg-blog-qa/providers/Microsoft.Compute/virtualMachines/blog1"
        
        
        
      }
    ]
    managed_disks = [
      
      
    ]
    virtual_machine_data_disk_attachments = [
      
      
    ]
  }
]

