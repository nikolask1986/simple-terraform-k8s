#Set provider to Digital Ocean
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

#Variables
variable "do_token" {}

#Set Token
provider "digitalocean" {
  token = var.do_token
}

