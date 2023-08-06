variable "ami" {}
variable "name" {}
variable "key_name" {
    type = string
    default = "key_name"
}
variable "instance_type" {}
variable "subnet_id" {}
variable "vpc_security_group_ids" {}
variable "associate_public_ip_address" {
  type = bool
  default = true
}
