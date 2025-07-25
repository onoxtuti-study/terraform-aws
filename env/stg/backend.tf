terraform {
  required_version = "1.12.2"
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.4.0"
    }
  }
  backend "s3" {
    bucket = "onozawa-terraform-tfstate"
    key    = "stg_terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}