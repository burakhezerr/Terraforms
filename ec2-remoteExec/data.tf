data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "aws_ami" "linux" {
    most_recent = true
    owners      = ["amazon"]
    name_regex  = "^amzn2-ami-hvm.*"
}

