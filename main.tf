provider "aws" {
  region     = "eu-central-1"
}

data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current_region" {}
data "aws_vpcs" "my_vpcs" {}
