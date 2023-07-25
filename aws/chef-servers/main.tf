provider "aws" {
  profile = "credentials"
  region = local.region
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 1.4.5"
    }
  }
}
locals {
  env = "dev"
  region = "us-east-1"
}

module "dev-vpc" {
 source = "../../module/vpc" 
 name = "${local.env}-vpc"
 azs = var.azs
 private_subnets = var.private_subnets
 public_subnets = var.public_subnets
 enable_dns_hostname = var.enable_dns_hostname
 enable_dns_support = var.enable_dns_support
}