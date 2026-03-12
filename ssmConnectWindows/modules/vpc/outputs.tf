output "vpc_id" {
    description = "ID of the VPC"
    value       = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
    description = "CIDR block of the VPC"
    value       = aws_vpc.vpc.cidr_block
}

output "public_subnets" {
    description = "List of public subnet objects"
    value       = [for subnet in aws_subnet.public_subnets : subnet]
}

output "private_subnets" {
    description = "List of private subnet objects"
    value       = [for subnet in aws_subnet.private_subnets : subnet]
}

output "windows_sg_id" {
    description = "ID of the Windows security group"
    value       = aws_security_group.windows_sg.id
}
