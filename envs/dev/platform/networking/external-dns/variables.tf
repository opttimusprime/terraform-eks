variable "region" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "eks_state_bucket" {
  type = string
}

variable "eks_state_key" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "namespace" {
  type    = string
  default = "external-dns"
}

variable "external_dns_chart_version" {
  type    = string
  default = "1.15.0"
}