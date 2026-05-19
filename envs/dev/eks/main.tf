module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project}-${var.environment}-eks"
  cluster_version = "1.30"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  #############################################
  # EKS Access Entry / RBAC Automation
  #############################################

  enable_cluster_creator_admin_permissions = true

  access_entries = {
    k8s_workstation = {
      principal_arn = data.terraform_remote_state.k8s_workstation.outputs.k8s_workstation_role_arn

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

          access_scope = {
            type = "cluster"
          }
        }
      }
    }

  }

  #############################################
  # Managed Node Group
  #############################################

  eks_managed_node_groups = {
    blue = {
      min_size     = 2
      max_size     = 3
      desired_size = 2

      instance_types = ["c7i-flex.large"]
      capacity_type  = "ON_DEMAND"
      #capacity_type  = "SPOT"
    }
  }

  #############################################
  # Cluster Addons
  #############################################

  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  tags = local.common_tags


  node_security_group_additional_rules = {
  ingress_self_all = {
    description = "Node to node all traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    type        = "ingress"
    self        = true
  }

  egress_all = {
    description      = "Allow all outbound traffic"
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    type             = "egress"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

cluster_security_group_additional_rules = {
  ingress_nodes_ephemeral = {
    description                = "Node groups to cluster API"
    protocol                   = "tcp"
    from_port                  = 1025
    to_port                    = 65535
    type                       = "ingress"
    source_node_security_group = true
  }
}
}
