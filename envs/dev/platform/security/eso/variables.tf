variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "eks_state_bucket" {
  type = string
}

variable "eks_state_key" {
  type = string
}

variable "external_secrets_chart_version" {
  type    = string
  default = "0.10.5"
}