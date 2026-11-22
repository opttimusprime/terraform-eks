
locals {
  oidc_provider_hostpath = trimsuffix(
    trimprefix(
      data.aws_eks_cluster.this.identity[0].oidc[0].issuer,
      "https://"
    ),
    "/"
  )

  controller_name = "aws-load-balancer-controller"

  controller_role_name = "${var.project}-${var.environment}-alb-controller-role"

  controller_policy_name = "${var.project}-${var.environment}-alb-controller-policy"
}
