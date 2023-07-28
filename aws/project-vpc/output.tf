output "vpc_id" {
  description = "The vpc ID"
  value       = module.project-vpc.vpc_id
}

output "public_subnets" {
  description = "IDs of public subnets"
  value       = module.project-vpc.public_subnets
}

output "private_subnets" {
  description = "IDs of private subnets"
  value       = module.project-vpc.private_subnets
}

output "ssh_sg" {
  description = "ssh sg ig"
  value       = module.vpc_sg.ssh_sg
}

output "http_sg" {
  description = "http sg ig"
  value       = module.vpc_sg.http_sg
}