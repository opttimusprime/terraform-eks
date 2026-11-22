
variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "controller_namespace" {
  type    = string
  default = "kube-system"
}

variable "controller_chart_version" {
  type    = string
  default = "1.14.0"
}
