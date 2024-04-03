terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }

    backend "s3" {
    bucket = "project2-terraform-backend"
      key = "project2/terraform.tfstate"
      region = "ca-central-1"
    }
}

provider "aws" {
  region = var.aws_region
}