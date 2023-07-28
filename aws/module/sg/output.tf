output "ssh_sg" {
  description = "ssh sg ig"
  value = aws_security_group.ssh_sg.id
}

output "http_sg" {
  description = "http sg ig"
  value = aws_security_group.http_sg.id
}
