locals {
  name_prefix = "${var.project}-${var.environment}"

  oidc_issuer = replace(
    data.aws_eks_cluster.this.identity[0].oidc[0].issuer,
    "https://",
    ""
  )

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}