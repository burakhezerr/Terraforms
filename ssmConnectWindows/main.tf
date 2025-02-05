module "ec2" {
    source = "./modules/ec2"

    iam_ssm_instance_profile = module.iam.iam_ssm_instance_profile  
    private_subnets          = module.vpc.private_subnets
    project_name             = var.project_name
    windowsAMI               = var.windowsAMI
    windows_sg_id            = module.vpc.windows_sg_id
    windows_instance_type    = var.windows_instance_type
}

module "iam" {
    source = "./modules/iam"

    project_name = var.project_name
}

module "vpc" {
    source = "./modules/vpc"  

    azs                  = local.availability_zones
    project_name         = var.project_name  
    region               = var.region
    subnet_count         = var.subnet_count
    vpc_endpoint_type    = var.vpc_endpoint_type
    vpc_cidr_block       = var.vpc_cidr_block
}