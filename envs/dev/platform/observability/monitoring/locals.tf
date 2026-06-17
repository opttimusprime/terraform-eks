locals {
  name = "${var.project}-${var.environment}-monitoring"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}