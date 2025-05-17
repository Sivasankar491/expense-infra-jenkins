terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.8"
    }
  }

  backend "s3" {
    bucket = "kotte-site"
    key    = "expense-bastion"
    region = "us-east-1"
    dynamodb_table = "kotte-site"
  }
}

provider "aws" {
    region = "us-east-1"
}