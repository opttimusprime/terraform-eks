locals {
  namespace            = "external-secrets"
  service_account_name = "external-secrets"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
    Component   = "external-secrets"
  }
}