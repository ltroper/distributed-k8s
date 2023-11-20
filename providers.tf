terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

# Configure the Linode Provider
provider "linode" {
  token = var.token
}