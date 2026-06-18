locals {
  cluster_name = data.terraform_remote_state.eks.outputs.cluster_name
  vpc_id       = data.aws_eks_cluster.eks.vpc_config[0].vpc_id

  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "true"
    Component   = "alb-controller"
  }
}