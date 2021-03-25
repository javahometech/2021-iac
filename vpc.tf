provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name        = "main-terraform-${terraform.workspace}"
    CostCenter  = "KHPAP-09876"
    Banglore    = "Banglore"
    Client      = "Jpmorgan"
    Environment = terraform.workspace
    AccountId   = data.aws_caller_identity.current.account_id
  }
}