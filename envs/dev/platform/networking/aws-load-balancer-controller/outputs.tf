
# 1. IAM Policy ARN
output "alb_controller_iam_policy_arn" {
  description = "IAM policy ARN for AWS Load Balancer Controller"
  value       = aws_iam_policy.controller.arn
}

# 2. IAM Role ARN
output "alb_controller_iam_role_arn" {
  description = "IAM role ARN for AWS Load Balancer Controller IRSA"
  value       = aws_iam_role.controller.arn
}

# 3. Kubernetes ServiceAccount
output "alb_controller_service_account" {
  description = "Kubernetes ServiceAccount used by AWS Load Balancer Controller"
  value       = kubernetes_service_account.controller.metadata[0].name
}

# 4. Helm Release
output "alb_controller_helm_release" {
  description = "Helm release name of AWS Load Balancer Controller"
  value       = helm_release.controller.name
}

# 5. Kubernetes Namespace
output "alb_controller_namespace" {
  description = "Namespace where AWS Load Balancer Controller is installed"
  value       = "kube-system"
}
