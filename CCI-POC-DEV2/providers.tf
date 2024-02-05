terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.89.0"
    }
  }
  cloud {
    organization = "CCI-Demo"
  
  workspaces {
      name = "dev2-deploy-v1_0"
    }
  }
}
provider "azurerm" {
 features {}
}
