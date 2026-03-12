variable "region" {
    description = "AWS region to deploy resources"
    type        = string
}

variable "project_name" {
    description = "Name of the project, used for resource naming"
    type        = string
}

variable "subnet_count" {
    description = "Number of subnets to create in each AZ"
    type        = number
    default     = 2
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "vpc_endpoint_type" {
    description = "Type of VPC endpoint (Interface or Gateway)"
    type        = string
    default     = "Interface"
}

variable "windowsAMI" {
    description = "AMI ID for the Windows instance"
    type        = string
}

variable "windows_instance_type" {
    description = "EC2 instance type for the Windows instance"
    type        = string
    default     = "t3.medium"
}
