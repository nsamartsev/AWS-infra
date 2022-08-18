terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.25.0"
    }
  }
  required_version = ">= 1.2.5"
}

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
}

data "aws_availability_zones" "working" {
}

data "aws_ami" "amazon_linux_latest" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
}

data "aws_caller_identity" "current" {
}

data "aws_region" "current_region" {
}

data "aws_vpcs" "my_vpcs" {
}

data "aws_vpcs" "prod_vps" {
  tags = {
    Name = "prod"
  }
}