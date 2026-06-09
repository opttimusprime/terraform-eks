resource "aws_iam_policy" "external_secrets" {
  name = "${var.project}-${var.environment}-external-secrets"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ]

        Resource = "*"
      }
    ]
  })

  tags = local.common_tags
}

module "external_secrets_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.39"

  role_name = "${var.project}-${var.environment}-external-secrets"

  role_policy_arns = {
    policy = aws_iam_policy.external_secrets.arn
  }

  oidc_providers = {
    eks = {
      provider_arn = data.aws_iam_openid_connect_provider.eks.arn

      namespace_service_accounts = [
        "${local.namespace}:${local.service_account_name}"
      ]
    }
  }

  tags = local.common_tags
}

resource "kubernetes_namespace" "external_secrets" {
  metadata {
    name = local.namespace
  }
}

resource "helm_release" "external_secrets" {
  depends_on = [
    module.external_secrets_irsa
  ]

  name       = "external-secrets"
  namespace  = local.namespace

  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "0.10.5"

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = local.service_account_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.external_secrets_irsa.iam_role_arn
  }

  wait    = true
  timeout = 600
}