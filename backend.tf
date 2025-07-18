terraform {
  required_version = "1.12.2"
  backend "s3" {
    bucket = "onozawa-terraform-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}