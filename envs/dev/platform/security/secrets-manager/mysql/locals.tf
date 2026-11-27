locals {
  secret_name = "${var.project}/${var.environment}/mysql"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}