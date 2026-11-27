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

variable "mysql_root_password" {
  type        = string
  description = "MySQL root password"
  sensitive   = true
}