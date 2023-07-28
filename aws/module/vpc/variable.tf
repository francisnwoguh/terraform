variable "azs" {}
variable "name" {}
variable "enable_dns_hostnames" {}
variable "enable_dns_support" {}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "instance_tenancy" {
  type = string
  default = "default"
}

#public subnet
variable "public_subnets" {}
variable "map_public_ip_on_launch" {
  type = bool
  default = true
}

#private subnet
variable "private_subnets" {}
variable "enable_nat_gateway" {
  type = bool
  default = true
}
variable "single_nat_gateway" {
  type = bool
  default = true
}

variable "destination_cidr_block" {
  default = "0.0.0.0/0"
}
