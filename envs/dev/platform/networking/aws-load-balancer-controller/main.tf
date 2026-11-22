
# Kubernetes ServiceAccount with IRSA annotation
resource "kubernetes_service_account" "controller" {
  metadata {
    name      = local.controller_name
    namespace = var.controller_namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.controller.arn
    }

    labels = {
      "app.kubernetes.io/name" = local.controller_name
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.controller
  ]
}

# Install AWS Load Balancer Controller using Helm
resource "helm_release" "controller" {
  name       = local.controller_name
  namespace  = var.controller_namespace
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = var.controller_chart_version

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "region"
    value = var.aws_region
  }

  set {
    name  = "vpcId"
    value = data.aws_eks_cluster.this.vpc_config[0].vpc_id
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.controller.metadata[0].name
  }

  wait    = true
  timeout = 600

  depends_on = [
    kubernetes_service_account.controller
  ]
}
