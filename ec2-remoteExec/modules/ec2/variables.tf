variable "instance_ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "instance_user" {
  description = "SSH user for the EC2 instance"
  type        = string
}

variable "default_tags" {
  description = "Default tags applied to all resources"
  type        = map(string)
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
}
