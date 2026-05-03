resource "aws_vpc" "main" {
  cidr_block           = local.current_config.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = format("%s_%s_vpc", var.project_name, terraform.workspace)
    Environment = terraform.workspace
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.current_config.subnet_cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name        = format("%s_%s_private_subnet", var.project_name, terraform.workspace)
    Environment = terraform.workspace
  }
}

resource "aws_instance" "app" {
  count = local.current_config.instance_count

  ami           = var.ami_id
  instance_type = local.current_config.instance_type
  subnet_id     = aws_subnet.private.id

  tags = {
    Name        = format("%s_%s_ec2_%02d", var.project_name, terraform.workspace, count.index)
    Environment = terraform.workspace
  }
}

