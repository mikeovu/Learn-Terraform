
provider "aws" {
    region = "us-east-2"
}

resource "aws_s3_bucket" "first_bucket" {
    bucket = "<your-name>-first-bucket"
}