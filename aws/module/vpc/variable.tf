variable "env" {}
variable "azs" {}
variable "" {}
variable "enable_dns_hostnames" {
  description = "should be true to enable DNS hostname in vpc"
  default = bool
}

variable "enable_dns_support" {
  description = "should be true to enable DNS support in vpc"
  default = bool
}

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
variable "private_subnet" {}
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