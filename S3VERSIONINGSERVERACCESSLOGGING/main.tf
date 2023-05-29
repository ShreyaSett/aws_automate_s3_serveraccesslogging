terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
    profile = "default"
}

module "s3_versioning_sclogs" {
    source = "../module_sc"
}