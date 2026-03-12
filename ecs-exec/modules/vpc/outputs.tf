output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnets" {
  description = "List of public subnet objects"
  value       = [for subnet in aws_subnet.public_subnets : subnet]
}

output "ecs_security_group_id" {
  description = "ID of the ECS security group"
  value       = aws_security_group.ecs_security_group.id
}
