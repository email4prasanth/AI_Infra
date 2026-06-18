locals {
  location = "eastus"
  tags = {
    owner       = "aitest"
    environment = terraform.workspace
  }
  project_name = {
    name = "aitest"
  }

  # AD Groups
  ad_groups = {
    "dev" = {
      "dev_qa"        = "aitest dev QA"
      "dev_developer" = "aitest dev Developer"
      "dev_manager"   = "aitest dev Manager"
    },
    "qa" = {
      "qa_qa"        = "aitest dev QA"
      "qa_developer" = "aitest dev Developer"
      "qa_manager"   = "aitest dev Manager"
    }
  }


  # Role Assignments
  role_assignments = {
    "dev" = {
      "dev_qa"        = { role = ["Reader"] },
      "dev_developer" = { role = ["Reader", "AcrPull", "AcrPush", "Virtual Machine User Login", "Storage Blob Data Reader", "Key Vault Secrets User"] } #USER
      "dev_manager"   = { role = ["Reader"] }
    },
    "qa" = {
      "qa_qa"        = { role = ["Reader"] },
      "qa_developer" = { role = ["Reader", "AcrPull", "AcrPush", "Virtual Machine User Login", "Storage Blob Data Reader", "Key Vault Secrets User"] } #USER
      "qa_manager"   = { role = ["Reader"] }
    }
  }
  # Define the CIDR ranges for each environment
  cidr_ranges = {
    "dev" = "10.101.0.0/16"
    "qa" = "10.102.0.0/16"
  }
  vnet_cidr = lookup(local.cidr_ranges, terraform.workspace)

  # Define the Key vault name
  key_vault_name = {
    dev = "${terraform.workspace}${local.project_name.name}kv",
    qa = "${terraform.workspace}${local.project_name.name}kv"
  }


  # Define the Backend VM's security group rules for each environment
  backend_security_group_rules = {
    "dev" = [
      {
        name                       = "allow-all"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
    "qa" = [
      {
        name                       = "allow-all"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  # Define VM configurations for each environment
  vm_configurations = {
    "dev" = {
      "backend" = {
        instance_type   = "Standard_B4as_v2"
        os_disk_size_gb = 128
        os_disk_type    = "StandardSSD_LRS"
      }
    },
    "qa" = {
      "backend" = {
        instance_type   = "Standard_B4as_v2"
        os_disk_size_gb = 128
        os_disk_type    = "StandardSSD_LRS"
      }
    }
  }
  # Helper variables for easier access
  backend_vm_config = local.vm_configurations[terraform.workspace]["backend"]

  # Blob Storage Configuration
  blob_storage_config = {
    "dev" = {
      account_replication_type = "LRS"
      access_tier              = "Cool"
    },
    "qa" = {
      account_replication_type = "LRS"
      access_tier              = "Cool"
    }
  }
  blob_storage = local.blob_storage_config[terraform.workspace]
  # Database for aitest
  postgres_config = {
    dev = {
      server_name        = "${terraform.workspace}-${local.project_name.name}-psqlserver-centralus"
      location           = "centralus"
      sku_name           = "B_Standard_B1ms"
      database_name      = local.project_name.name
      database_collation = "en_US.utf8"
      database_charset   = "UTF8"
      firewall_rule_name = "AllowAll"
      firewall_start_ip  = "0.0.0.0"
      firewall_end_ip    = "255.255.255.255"

      main_database_service = {
        storage_tier = "P6"
        storage_mb   = 65536 # 64 GiB
      }
    },
    qa = {
      server_name        = "${terraform.workspace}-${local.project_name.name}-psqlserver-centralus"
      location           = "centralus"
      sku_name           = "B_Standard_B1ms"
      database_name      = local.project_name.name
      database_collation = "en_US.utf8"
      database_charset   = "UTF8"
      firewall_rule_name = "AllowAll"
      firewall_start_ip  = "0.0.0.0"
      firewall_end_ip    = "255.255.255.255"

      main_database_service = {
        storage_tier = "P6"
        storage_mb   = 65536 # 64 GiB
      }
    }
  }
  current_postgres_config = local.postgres_config[terraform.workspace]
  # Define method and headers for API Management
  allowed_methods = ["GET", "POST", "DELETE", "OPTIONS", "PUT"]

}