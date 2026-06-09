locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }

  namespace            = "external-secrets"
  service_account_name = "external-secrets"
}