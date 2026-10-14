terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.98.0"
    }
  }

  
    backend "s3" {
    bucket = "sivarobots-roboshop-dev-bucket"
    key    = "roboshop-dev-vpc"
    region = "us-east-1"
    use_lockfile = true
  }
  
}

provider "aws" {
  region = "us-east-1"
  # Configuration options
}