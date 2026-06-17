data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = var.eks_state_bucket
    key    = var.eks_state_key
    region = var.region
  }
}

data "aws_eks_cluster" "this" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = data.aws_eks_cluster.this.name
}

data "aws_route53_zone" "this" {
  name         = var.domain_name
  private_zone = false
}