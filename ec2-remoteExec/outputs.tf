output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2_remote_exec.instance_public_ip
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.public_subnets[0].vpc_id
}
