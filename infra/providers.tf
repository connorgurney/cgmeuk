# Terraform configuration
terraform {
  backend "s3" {
    region = "eu-west-2"

    bucket               = "connorgurney-homelab-iac-state"
    key                  = "cgmeuk"
    workspace_key_prefix = ""

    dynamodb_table = "connorgurney-homelab-iac-locks"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS provider
provider "aws" {
  region = "eu-west-2"
  
  default_tags {
    tags = {
      "connorgurney-workload"    = "cgmeuk"
      "connorgurney-environment" = var.environment
    }
  }
}
