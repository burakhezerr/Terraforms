module "vpc" {
    source = "./modules/vpc"  


    project_name = var.project_name  
    region       = var.region
    azs          = var.azs
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    subnet_count = var.subnet_count
    cidr_block = var.vpc_cidr_block
}

module "ec2" {
    source = "./modules/ec2"


    project_name             = var.project_name
    private_subnets          = module.vpc.private_subnets
    windows_sg               = module.vpc.windows_sg
    iam_ssm_instance_profile = module.iam.iam_ssm_instance_profile  
}

module "iam" {
    source = "./modules/iam"

    project_name = var.project_name
}