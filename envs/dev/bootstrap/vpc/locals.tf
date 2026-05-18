locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }


  # Take first 2 AZs automatically (matches your network module input)
  azs = slice(sort(data.aws_availability_zones.available.names), 0, 2)

}