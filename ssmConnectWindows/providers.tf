terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
        local = {
            source  = "hashicorp/local"
            version = "~> 2.5.2"
        }
        tls = {
            source  = "hashicorp/tls"
            version = "~> 3.0"
        }
    } 
}


provider "aws" {
    region = var.region
}

provider "tls" {}

provider "local" {}