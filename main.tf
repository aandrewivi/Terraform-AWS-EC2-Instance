terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.94.1"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  version = "~> 5.0"
  region  = "us-east-1"
}


# Configure the AWS Provider

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "Terraform-EC2"

  instance_type          = "t2.micro"
  key_name               = "All_Practice-Key"
  monitoring             = true
  vpc_security_group_ids = ["sg-0f9003dd48b34cbbb"]
  subnet_id              = "subnet-0a5bec79d2dd7dbfc"

  tags = {
    Terraform   = "true"
    Environment = "development"
  }
}


# Configure the AWS Provider

module "Terraform-SG" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Terraform-SG"
  description = "Security group for web server"
  vpc_id      = "sg-0f9003dd48b34cbbb"

  ingress_rules = ["ssh-tcp", "http-80-tcp"]
  egress_rules  = ["all-all"]
}
