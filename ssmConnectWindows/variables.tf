variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "region" {
    description = "The region in which to create the VPC"
    type        = string
}


variable "azs" {
    description = "The availability zones in which to create the subnets"
    type        = list(string)
}

variable "public_subnet_cidrs" {
    description = "The CIDR blocks for the public subnets"
    type        = list(string)
}

variable "private_subnet_cidrs" {
    description = "The CIDR blocks for the private subnets"
    type        = list(string)
}

variable "subnet_count" {
    description = "The number of public and private subnets to create"
    type        = number
}

variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
}

variable "vpc_endpoint_type" {
    description = "The type of VPC endpoint to create"
    type        = string
}

variable "windowsAMI" {
    description = "The AMI ID for the Windows instance"
    type        = string
}

variable "windows_instance_type" {
    description = "The instance type for the Windows instance"
    type        = string
}