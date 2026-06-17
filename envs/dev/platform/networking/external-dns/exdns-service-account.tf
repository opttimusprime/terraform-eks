module "external_dns_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "${local.name_prefix}-external-dns-role"

  role_policy_arns = {
    external_dns = aws_iam_policy.external_dns.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = data.terraform_remote_state.eks.outputs.oidc_provider_arn
      namespace_service_accounts = ["${var.namespace}:${local.service_account_name}"]
    }
  }

  tags = local.common_tags
}

resource "kubernetes_namespace" "external_dns" {
  metadata {
    name = var.namespace

    labels = {
      "app.kubernetes.io/name"       = "external-dns"
      "app.kubernetes.io/managed-by" = "terraform"
      "project"                      = var.project
      "environment"                  = var.environment
    }
  }
}

resource "kubernetes_service_account" "external_dns" {
  metadata {
    name      = local.service_account_name
    namespace = kubernetes_namespace.external_dns.metadata[0].name

    annotations = {
      "eks.amazonaws.com/role-arn" = module.external_dns_irsa.iam_role_arn
    }

    labels = {
      "app.kubernetes.io/name"       = "external-dns"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  depends_on = [
    module.external_dns_irsa
  ]
}