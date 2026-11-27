# S3 IAM Policy
resource "aws_iam_policy" "shipping_s3" {
  name        = "${local.name_prefix}-shipping-s3-policy"
  description = "Allow Shipping DB initialization Job to read SQL files from S3"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject"
        ]

        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}/${var.s3_prefix}/*"
        ]
      }
    ]
  })

  tags = local.common_tags
}

# IAM Role with OIDC Trust Policy
resource "aws_iam_role" "shipping_db_init" {
  name = "${local.name_prefix}-shipping-db-init-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = data.aws_iam_openid_connect_provider.this.arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "${local.oidc_issuer}:aud" = "sts.amazonaws.com"
            "${local.oidc_issuer}:sub" = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
          }
        }
      }
    ]
  })

  tags = local.common_tags
}

# Attach IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "shipping_s3" {
  role       = aws_iam_role.shipping_db_init.name
  policy_arn = aws_iam_policy.shipping_s3.arn
}