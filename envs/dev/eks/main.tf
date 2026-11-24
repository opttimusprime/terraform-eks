
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project}-${var.environment}-eks"
  cluster_version = "1.35"

  # EKS API endpoint
  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  # Existing VPC and private subnets
  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  # Disable additional customer-managed KMS key
  create_kms_key            = false
  cluster_encryption_config = {}

  # Disable EKS control-plane CloudWatch logging
  create_cloudwatch_log_group = false
  cluster_enabled_log_types   = []

  enable_cluster_creator_admin_permissions = false

  # EKS access entries
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

  # EKS managed node groups
  eks_managed_node_groups = {
    blue = {
      min_size     = 2
      max_size     = 3
      desired_size = 2

      instance_types = ["c7i-flex.large"]
      capacity_type  = "ON_DEMAND"
    }
  }

  # Core Kubernetes add-ons
  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  # Cluster security group rules
  cluster_security_group_additional_rules = {
    ingress_vpc_https = {
      description = "Allow resources inside roboshop VPC to access EKS API"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = [data.terraform_remote_state.vpc.outputs.vpc_cidr]
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

  # Worker node security group rules
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
