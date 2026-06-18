terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "aiado-terraform-rg"
    storage_account_name = "aiadosto"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {} 
}

provider "tls" {

}