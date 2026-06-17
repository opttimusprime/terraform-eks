resource "aws_iam_policy" "external_dns" {
  name        = "${local.name_prefix}-external-dns-policy"
  description = "IAM policy for external-dns to manage Route53 records"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "route53:ChangeResourceRecordSets"
        ]

        Resource = [
          data.aws_route53_zone.this.arn
        ]
      },
      {
        Effect = "Allow"

        Action = [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ]

        Resource = "*"
      }
    ]
  })

  tags = local.common_tags
}