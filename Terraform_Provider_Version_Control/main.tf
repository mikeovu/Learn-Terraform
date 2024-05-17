provider "aws" {
  region  = "us-east-2"
}

terraform {
  required_providers {
    aws = {
      version = "~> 3.46"
    }
  }
}