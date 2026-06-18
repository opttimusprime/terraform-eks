variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  type    = string
  default = "roboshop"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "repositories" {
  type = list(string)

  default = [
    "catalogue",
    "frontend",
    "cart",
    "user",
    "payment",
    "shipping",
    "dispatch"
  ]
}