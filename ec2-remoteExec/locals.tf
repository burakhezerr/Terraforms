locals {
  region       = "eu-central-1"
  project_name = "burak-skyloop"

  # EC2 instance configuration
  instance_ami_id             = data.aws_ami.linux.id
  instance_type               = "t2.micro"
  instance_user               = "ec2-user"
  instance_name               = "terraform-ec2-remote-exec"
  associate_public_ip_address = true

  # VPC configuration
  vpc_config = {
    subnet_count   = 2
    vpc_cidr_block = "10.0.0.0/16"
  }

  default_tags = {
    Owner     = "burak"
    Project   = "terraform-ec2"
    Purpose   = "terraform-ec2-remote-exec"
    ManagedBy = "terraform"
  }
}
