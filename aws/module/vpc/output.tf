output "vpc_id" {
  description = "The vpc ID"
  value = aws_vpc.net-vpc
}

output "public_subnet" {
  description = "IDs of public subnets"
  value = aws_subnet.public_subnets.*.id
}

output "private_subnet" {
  description = "IDs of private subnets"
  value = aws_subnet.private_subnets.*.id
}