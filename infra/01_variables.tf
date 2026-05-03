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
