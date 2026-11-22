
variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region for ACM certificate"
  type        = string
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "create_root_domain_certificate" {
  description = "Include the root domain in ACM certificate"
  type        = bool
  default     = true
}
