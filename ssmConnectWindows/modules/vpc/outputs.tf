output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
    value = aws_vpc.vpc.cidr_block
}

output "public_subnets" {
    value = [for subnet in aws_subnet.public_subnets : subnet]
}

output "private_subnets" {
    value = [for subnet in aws_subnet.private_subnets : subnet]
}

output "windows_sg_id" {
    value = aws_security_group.windows_sg.id
}
