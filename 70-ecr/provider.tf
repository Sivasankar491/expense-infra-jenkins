terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.8"
    }
  }

  backend "s3" {
    bucket = "kotte-site"
    key = "expense-ecr"
    dynamodb_table = "kotte-site"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}