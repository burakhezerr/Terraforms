variable "project_name" {
    description = "Name of the project, used for resource naming"
    type        = string
}

variable "region" {
    description = "AWS region"
    type        = string
}

variable "azs" {
    description = "List of availability zone names"
    type        = list(string)
}

variable "subnet_count" {
    description = "Number of subnets to create"
    type        = number
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
}

variable "default_tags" {
    description = "Default tags applied to all resources"
    type        = map(string)
}
