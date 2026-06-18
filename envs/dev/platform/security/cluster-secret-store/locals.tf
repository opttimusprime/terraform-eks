locals {
  cluster_secret_store_name = "aws-secretsmanager"
  eso_namespace             = "external-secrets"
  eso_service_account       = "external-secrets"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
    Component   = "cluster-secret-store"
  }
}