locals {
    instance_ami_id = data.aws_ami.linux.id
    instance_type = "t2.micro"
    instance_user = "ec2-user"
    associate_public_ip_address = true
    instance_name = "terraform-ec2-remote-exec"
}

locals {
    default_tags = {
        Owner   = "burak"
        Project = "terraform-ec2"
        Purpose = "terraform-ec2-remote-exec"
    }
    project_name = "burak-skyloop"
    region       = "eu-central-1"
}

locals {
    vpc_1 = {
        region = "eu-central-1"
        subnet_count = 2
        vpc_cidr_block = "10.0.0.0/16"
    }
}