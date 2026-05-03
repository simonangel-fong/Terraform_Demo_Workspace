output "workspace" {
  description = "Current Terraform workspace"
  value       = terraform.workspace
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}

output "ec2_ids" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.app[*].id
}
