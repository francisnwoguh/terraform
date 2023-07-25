resource "aws_instance" "front-end" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
}