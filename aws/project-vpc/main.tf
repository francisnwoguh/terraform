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
  name   = "bastion-host"
  project = "project-vpc"
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}


module "project-vpc" {
  source               = "../../aws/module/vpc"
  name                 = "${local.env}-${local.project}"
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

module "bastion-host" {
  source                      = "../../aws/module/bastion"
  name                        = local.name
  instance_type               = var.instance_type
  ami                         = data.aws_ami.amzn-linux-2023-ami.id
  vpc_security_group_ids      = [module.vpc_sg.ssh_sg, module.vpc_sg.http_sg]
  subnet_id                   = element(module.project-vpc.public_subnets, 0)
  associate_public_ip_address = var.associate_public_ip_address
}
