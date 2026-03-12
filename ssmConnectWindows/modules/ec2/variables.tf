variable "iam_ssm_instance_profile" {
    description = "IAM instance profile name for SSM access"
    type        = string
}

variable "private_subnets" {
    description = "List of private subnet objects"
    type        = list(any)
}

variable "project_name" {
    description = "Name of the project, used for resource naming"
    type        = string
}

variable "windowsAMI" {
    description = "AMI ID for the Windows instance"
    type        = string
}

variable "windows_instance_type" {
    description = "EC2 instance type for the Windows instance"
    type        = string
}

variable "windows_sg_id" {
    description = "Security group ID for the Windows instance"
    type        = string
}
