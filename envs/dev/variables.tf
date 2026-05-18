############################
# Core
############################
variable "aws_region" { type = string }
variable "project" { type = string }
variable "environment" { type = string }

############################
# Network
############################
variable "dev_vpc_cidr" { type = string }
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}