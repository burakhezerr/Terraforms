output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
    value = aws_vpc.vpc.cidr_block
}

output "public_subnets" {
    value = aws_subnet.public_subnets
}

output "private_subnets" {
    value = aws_subnet.private_subnets
}

output "windows_sg" {
    value = aws_security_group.windows_sg.id
}
