provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster" "eks" {
  name = "${var.project}-${var.environment}-eks"
}

data "aws_eks_cluster_auth" "eks" {
  name = "${var.project}-${var.environment}-eks"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}