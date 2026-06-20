variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "remote_state_bucket" {
  description = "Terraform remote state bucket"
  type        = string
}

variable "domain_name" {
  description = "Base domain name"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  type        = string
}

variable "allowed_ingress_cidr" {
  description = "Allowed CIDR for Grafana and Prometheus access"
  type        = string
}

variable "grafana_admin_password" {
  type      = string
  sensitive = true
}