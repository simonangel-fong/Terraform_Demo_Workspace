terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket               = ""
    region               = ""
    workspace_key_prefix = "tf-demo-workspace"
    key                  = "terraform.tfstate"
    encrypt              = true
    use_lockfile         = true
  }
}

provider "aws" {
  region = var.aws_region
}
