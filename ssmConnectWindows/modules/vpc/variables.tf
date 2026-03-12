variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
}

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

variable "vpc_endpoint_type" {
    description = "Type of VPC endpoint (Interface)"
    type        = string
    default     = "Interface"
}

variable "all_cidr_block" {
    description = "CIDR block representing all traffic"
    type        = string
    default     = "0.0.0.0/0"
}
