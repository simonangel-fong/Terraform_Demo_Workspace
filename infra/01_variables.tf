variable "project_name" {
  description = ""
  type        = string
  default     = "demo-tf-workspace"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (Amazon Linux 2023 in ca-central-1)"
  type        = string
  default     = "ami-0dd6ad74006372963"
}

variable "availability_zone" {
  description = "Availability zone for the private subnet"
  type        = string
  default     = "ca-central-1a"
}

variable "vpc_cidr_block" {
  description = "VPC cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "Subnet cidr block"
  type        = string
  default     = "10.0.1.0/24"
}
