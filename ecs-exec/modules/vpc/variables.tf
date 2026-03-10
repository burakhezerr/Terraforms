variable "project_name" {}

variable "region" {}

variable "azs" {}

variable "subnet_count" {}

variable "vpc_cidr_block" {}

variable "all_cidr_block" {
    type = string
    description = "All traffic CIDR Block"
    default = "0.0.0.0/0"
}