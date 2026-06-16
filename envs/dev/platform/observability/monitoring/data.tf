data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "dev/eks/terraform.tfstate"
    region = var.aws_region
  }
}

data "aws_acm_certificate" "wildcard" {
  domain      = "*.optimusprime.uno"
  statuses    = ["ISSUED"]
  most_recent = true
}