output "windows_instance_id" {
    description = "ID of the Windows EC2 instance"
    value       = module.ec2.windows_instance_id
}

output "vpc_id" {
    description = "ID of the VPC"
    value       = module.vpc.vpc_id
}
