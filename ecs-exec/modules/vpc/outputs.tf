output "vpc_id" {
    value = aws_vpc.vpc.id
}

# output "private_subnets" {
#     value = [for subnet in aws_subnet.private_subnets : subnet]
# }

output "public_subnets" {
    value = [for subnet in aws_subnet.public_subnets : subnet]
}

output "ecs_security_group_id" {
    value = aws_security_group.ecs_security_group.id
}