provider "aws" {
    region = "us-east-1"
    access_key = "AKIAQZ5F77RSGRPIYM7U"
    secret_key = "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"
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

