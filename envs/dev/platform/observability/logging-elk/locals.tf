locals {
  name = "${var.project}-${var.environment}-elk"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
    Component   = "logging-elk"
  }
}