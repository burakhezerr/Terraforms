module "ec2_remote_exec" {
  source = "./modules/ec2"

  instance_ami_id             = local.instance_ami_id
  instance_name               = local.instance_name
  instance_type               = local.instance_type
  instance_user               = local.instance_user
  associate_public_ip_address = local.associate_public_ip_address
  default_tags                = local.default_tags
  subnet_id                   = module.vpc.public_subnets[0].id
  vpc_security_group_ids      = [module.vpc.ec2_remote_exec_security_group_id]
}

module "vpc" {
  source = "./modules/vpc"

  azs            = data.aws_availability_zones.available.names
  default_tags   = local.default_tags
  project_name   = local.project_name
  region         = local.region
  subnet_count   = local.vpc_config.subnet_count
  vpc_cidr_block = local.vpc_config.vpc_cidr_block
}
