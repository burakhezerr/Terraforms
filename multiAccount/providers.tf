terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "5.93"
        }
    }
}

provider "aws" {
    alias   = "skyloop"
    region  = local.region_1
    profile = local.project_name_1
}

provider "aws" {
    alias   = "levelafrica"
    region  = local.region_2
    profile = local.project_name_2
}