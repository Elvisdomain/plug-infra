provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "plug-api-tf"
    key            = "plug-api.tf-state"
    region         = "af-south-1"
  }
}