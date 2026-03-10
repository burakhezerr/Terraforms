terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "5.88.0"
        }
        tls = {
            source  = "hashicorp/tls"
            version = "4.0.4"
        }
        local = {
            source  = "hashicorp/local"
            version = "2.4.0"
        }
    }
}

provider "aws" {
    region = local.region
    profile = "burakSkyloop"
}