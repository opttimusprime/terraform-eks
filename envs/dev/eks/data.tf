data "aws_availability_zones" "available" {
  state = "available"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "roboshop-tf-state"
    key    = "dev/bootstrap/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "k8s_workstation" {
  backend = "s3"

  config = {
    bucket = "roboshop-tf-state"
    key    = "dev/bootstrap/k8s-workstation/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "jenkins" {
  backend = "s3"

  config = {
    bucket = "opttimusprime-jenkins-tf-state"
    key    = "jenkins/dev/terraform.tfstate"
    region = "us-east-1"
  }
}