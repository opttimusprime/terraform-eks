data "aws_availability_zones" "available" {
  state = "available"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "roboshop-tf-state-optimusprime"
    key    = "roboshop/dev/bootstrap/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "roboshop-tf-state-optimusprime"
    key    = "roboshop/dev/eks/terraform.tfstate"
    region = "us-east-1"
  }
}
