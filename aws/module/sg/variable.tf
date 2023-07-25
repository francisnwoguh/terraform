variable "http_port" {
  type = string
  default = "80"
}

variable "ssh_port" {
  type = string
  default = "22"
}

variable "cidr_block" {
  type = string
  default = "0.0.0.0/0"
}

variable "protocol" {
  type = string
  default = "tcp"
}

variable "vpc_id" {}