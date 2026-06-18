data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "roboshop-tf-state"
    key    = "dev/eks/terraform.tfstate"
    region = var.aws_region
  }
}

data "aws_eks_cluster" "eks" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_iam_openid_connect_provider" "oidc" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}