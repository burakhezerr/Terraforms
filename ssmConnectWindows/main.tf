module "ec2" {
    source = "./modules/ec2"

    iam_ssm_instance_profile = module.iam.iam_ssm_instance_profile  
    private_subnets          = module.vpc.private_subnets
    project_name             = var.project_name
    windowsAMI               = var.windowsAMI
    windows_sg               = module.vpc.windows_sg
    windows_instance_type    = var.windows_instance_type
}

module "iam" {
    source = "./modules/iam"

    project_name = var.project_name
}

module "vpc" {
    source = "./modules/vpc"  

    azs                  = var.azs
    cidr_block           = var.vpc_cidr_block
    private_subnet_cidrs = var.private_subnet_cidrs
    project_name         = var.project_name  
    public_subnet_cidrs  = var.public_subnet_cidrs
    region               = var.region
    subnet_count         = var.subnet_count
    vpc_endpoint_type    = var.vpc_endpoint_type
}