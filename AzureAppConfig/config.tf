terraform {
  # Require any 0.12.x version of terraform
  required_version = ">= 0.12, < 0.13"
  backend "local" {
   path = "./terraform.tfstate"
 }
}

provider "azurerm" {
  version = "~> 2.0"
  features{}
}

