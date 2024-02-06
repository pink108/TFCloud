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
      name = ["nte1","nte2"]
    }
  }
}
provider "azurerm" {
 features {}
}
