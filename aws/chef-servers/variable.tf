variable "name" {
  type = list(string)
  default = [ "workstation", "server", "client" ]
}

variable "azs" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
}

variable "private_subnets" {
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "public_subnets" {
  type = list(string)
  default = [ "10.0.10.0/24", "10.0.20.0/24" ]
}

variable "enable_dns_hostname" {
  type = bool
  default = true
}

variable "enable_dns_support" {
  type = bool
  default = true
}
