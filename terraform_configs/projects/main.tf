terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
  }
}

provider "aws" {
  # Configuration options
}


module "hello-world-go-app" {
  source       = "../modules"
  project_name = "hello-world-go-app"
  vpc_block    = "192.168.0.0/16"
  private_subnet_block = {
    Private_Subnet01 = {
      block             = "192.168.100.0/24"
      availability_zone = "us-east-1a"
    }
    Private_Subnet02 = {
      block             = "192.168.50.0/24"
      availability_zone = "us-east-1b"
    }
  }
  public_subnet_block = {
    Public_Subnet01 = {
      block             = "192.168.20.0/24"
      availability_zone = "us-east-1a"
    }
    Public_Subnet02 = {
      block             = "192.168.40.0/24"
      availability_zone = "us-east-1b"
    }
  }
}
