output "ec2_remote_exec_security_group_id" {
  description = "ID of the EC2 remote exec security group"
  value       = aws_security_group.ec2_remote_exec_sg.id
}

output "public_subnets" {
  description = "List of public subnet objects"
  value       = [for subnet in aws_subnet.public_subnets : subnet]
}
