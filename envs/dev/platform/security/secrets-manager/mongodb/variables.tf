variable "aws_region" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "mongodb_root_username" {
  type      = string
  sensitive = true
}

variable "mongodb_root_password" {
  type      = string
  sensitive = true
}

variable "mongodb_replicaset_key" {
  type      = string
  sensitive = true
}