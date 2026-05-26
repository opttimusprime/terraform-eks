variable "aws_region" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "helm_values_file" {
  description = "Environment specific MongoDB Helm values file"
  type        = string
}