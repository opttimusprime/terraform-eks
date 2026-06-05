module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project}-${var.environment}-eks"
  cluster_version = "1.30"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  enable_cluster_creator_admin_permissions = false

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

      jenkins = {
        principal_arn = data.terraform_remote_state.jenkins.outputs.jenkins_role_arn

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

  eks_managed_node_groups = {
    blue = {
      min_size     = 2
      max_size     = 3
      desired_size = 2

      instance_types = ["c7i-flex.large"]
      capacity_type  = "ON_DEMAND"
    }
  }

  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  cluster_security_group_additional_rules = {
    ingress_k8s_workstation_https = {
      description = "Allow k8s workstation to access EKS API"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = ["10.10.0.0/16"]
    }

    ingress_nodes_ephemeral = {
      description                = "Allow nodes to communicate with cluster API"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = true
    }
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Allow node-to-node communication"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }

  tags = local.common_tags
}
