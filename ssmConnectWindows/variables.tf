variable "project_name" {
    description = "The name of the project"
    type        = string
    default     = "ssmWindowsPrivate"
}

variable "region" {
    description = "The region in which to create the VPC"
    type        = string
    default     = "eu-central-1"
}


variable "azs" {
    description = "The availability zones in which to create the subnets"
    type        = list(string)
    default     = ["a", "b", "c"]
}

variable "public_subnet_cidrs" {
    description = "The CIDR blocks for the public subnets"
    type        = list(string)
    default     = ["10.0.0.0/24", "10.0.2.0/24", "10.0.4.0/24"]
}

variable "private_subnet_cidrs" {
    description = "The CIDR blocks for the private subnets"
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
}

variable "subnet_count" {
    description = "The number of public and private subnets to create"
    type        = number
    default     = 2
}

variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

