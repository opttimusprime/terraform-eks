locals {
  cluster_name = data.terraform_remote_state.eks.outputs.cluster_name
  vpc_id       = data.terraform_remote_state.eks.outputs.vpc_id
}