locals {
  name_prefix = "${var.project}-${var.environment}"

  service_account_name = "external-dns"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}