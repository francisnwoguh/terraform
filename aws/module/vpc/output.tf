output "vpc_id" {
  description = "The vpc ID"
  value = "${aws_vpc.net-vpc.id}"
}

output "public_subnets" {
  description = "IDs of public subnets"
  value = "${aws_subnet.public_subnets.*.id}"
}

output "private_subnets" {
  description = "IDs of private subnets"
  value = "${aws_subnet.private_subnets.*.id}"
}
