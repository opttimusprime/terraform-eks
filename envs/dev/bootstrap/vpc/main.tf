module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  #############################################
  # Core
  #############################################
  name = "${var.project}-${var.environment}-vpc"



  #############################################
  # VPC and Subnets
  #############################################
  cidr            = var.dev_vpc_cidr
  azs             = local.azs
  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs


  #############################################
  # NAT Gateway
  #############################################

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  #############################################
  # Kubernetes Tags
  #############################################
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }


  #############################################
  # EKS Cluster Discovery & Common Tags
  #############################################
  tags = local.common_tags

}
