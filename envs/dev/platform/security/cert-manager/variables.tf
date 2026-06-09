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

variable "cert_manager_namespace" {
  type    = string
  default = "cert-manager"
}

variable "cert_manager_chart_version" {
  type    = string
  default = "v1.15.3"
}

variable "letsencrypt_email" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "enable_qa_cluster_issuer" {
  type    = bool
  default = false
}

variable "enable_preprod_cluster_issuer" {
  type    = bool
  default = false
}

variable "enable_prod_cluster_issuer" {
  type    = bool
  default = false
}