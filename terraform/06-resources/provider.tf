# This Terraform configuration file defines the required providers for the project.
terraform {
  required_version = ">= 1.7.0"
  # Required providers block
  # This block specifies the providers that Terraform will use for this configuration.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# This provider block configures the AWS provider to use a specific region.
provider "aws" {
  region = "us-west-2" # Specify the AWS region to use
}