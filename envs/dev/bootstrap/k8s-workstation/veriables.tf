variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "key_name" {
  type        = string
  description = "AWS EC2 key pair name for SSH access"
}

variable "my_ip" {
  type        = string
  description = "Your laptop public IP address with /32"
}

variable "workstation_instance_type" {
  type        = string
  description = "EC2 instance type for k8s workstation"
}
