locals {
  account_id     = data.aws_caller_identity.current.account_id
  project_name   = "burakdemo"
  region         = "eu-central-1"
  subnet_count   = 2
  vpc_cidr_block = "10.10.0.0/16"

  common_tags = {
    ManagedBy = "terraform"
    Owner     = "burak"
    Project   = local.project_name
  }
}
