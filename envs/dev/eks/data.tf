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

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}
