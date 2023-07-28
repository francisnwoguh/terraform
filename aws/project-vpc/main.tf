provider "aws" {
  profile = "profile"
  region  = local.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.4.5"
    }
  }
}
locals {
  env    = "dev"
  region = "us-east-1"
}

module "project-vpc" {
  source               = "../../aws/module/vpc"
  name                 = "${local.env}-${var.name}"
  azs                  = var.azs
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_dns_hostnames = var.enable_dns_hostname
  enable_dns_support   = var.enable_dns_support
}

module "vpc_sg" {
  source = "../../aws/module/sg"
  name   = "${local.env}-sg"
  vpc_id = module.project-vpc.vpc_id
}
