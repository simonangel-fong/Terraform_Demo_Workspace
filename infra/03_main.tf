# ##############################
# VPC
# ##############################
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = format("%s_%s_vpc", var.project_name, terraform.workspace)
    Environment = terraform.workspace
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name        = format("%s_%s_private_subnet", var.project_name, terraform.workspace)
    Environment = terraform.workspace
  }
}

# ##############################
# ec2
# ##############################
resource "aws_instance" "app" {
  count = terraform.workspace == "prod" ? 3 : 1

  ami           = var.ami_id
  instance_type = terraform.workspace == "prod" ? "t2.large" : "t2.micro"
  subnet_id     = aws_subnet.private.id

  tags = {
    Name        = format("%s_%s_ec2_%02d", var.project_name, terraform.workspace, count.index)
    Environment = terraform.workspace
  }
}

