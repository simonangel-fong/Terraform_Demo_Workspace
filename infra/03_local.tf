locals {
  workspace_config = {
    dev = {
      cidr_block        = "10.0.0.0/16"
      subnet_cidr_block = "10.0.1.0/24"
      instance_type     = "t2.micro"
      instance_count    = 1
    }
    prod = {
      cidr_block        = "10.1.0.0/16"
      subnet_cidr_block = "10.1.1.0/24"
      instance_type     = "t2.large"
      instance_count    = 3
    }
  }

  current_config = local.workspace_config[terraform.workspace]
}
