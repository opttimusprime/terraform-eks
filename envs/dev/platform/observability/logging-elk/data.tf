data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "dev/vpc/terraform.tfstate"
    region = var.aws_region
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

data "aws_route53_zone" "this" {
  name         = var.domain_name
  private_zone = false
}