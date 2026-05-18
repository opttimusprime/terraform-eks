module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  #############################################
  # Cluster
  #############################################

  cluster_name    = "${var.project}-${var.environment}-eks"
  cluster_version = "1.30"

  #############################################
  # Endpoint Access
  #############################################

  cluster_endpoint_public_access = true

  #############################################
  # VPC Configuration
  #############################################

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  #############################################
  # Managed Node Group
  #############################################

  eks_managed_node_groups = {

    blue = {

      min_size     = 2
      max_size     = 3
      desired_size = 2

      instance_types = ["c7i-flex.large"]

      capacity_type = "ON_DEMAND"
    }
  }

  #############################################
  # Cluster Addons
  #############################################

  cluster_addons = {
    coredns = {}
    kube-proxy = {}
    vpc-cni = {}
  }

  #############################################
  # Tags
  #############################################

  tags = local.common_tags
}