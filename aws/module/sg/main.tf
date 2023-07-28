resource "aws_security_group" "ssh_sg" {
  description = "allow ssh traffic"
  vpc_id = var.vpc_id

  ingress {
    description = "ssh"
    from_port = var.ssh_port
    to_port = var.ssh_port
    protocol = var.protocol
    cidr_blocks = var.cidr_block
  }

  egress {
    description = "ssh"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-sg"
  }
}

resource "aws_security_group" "http_sg" {
  description = "allow http traffic"
  vpc_id = var.vpc_id

  ingress {
    description = "http"
    from_port = var.http_port
    to_port = var.http_port
    protocol = var.protocol
    cidr_blocks = var.cidr_block
  }

  egress {
    description = "http"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "http-sg"
  }
}
