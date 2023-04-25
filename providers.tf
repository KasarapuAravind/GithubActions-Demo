provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}

terraform {
    backend "s3" {
        bucket = "aravindbucket004"
        region = "us-east-1"
    }
    required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "4.62.0"
        }
    }
}

