
# IAM Policy ARN for AWS Load Balancer Controller
output "alb_controller_iam_policy_arn" {
  description = "IAM policy ARN for AWS Load Balancer Controller"
  value       = aws_iam_policy.alb_controller.arn
}

# IAM Role ARN for IRSA
output "alb_controller_iam_role_arn" {
  description = "IAM role ARN used by AWS Load Balancer Controller"
  value       = aws_iam_role.alb_controller.arn
}

# Kubernetes ServiceAccount
output "alb_controller_service_account" {
  description = "Kubernetes ServiceAccount used by the controller"
  value       = kubernetes_service_account.alb_controller.metadata[0].name
}

# Helm Release
output "alb_controller_helm_release" {
  description = "Helm release name of AWS Load Balancer Controller"
  value       = helm_release.alb_controller.name
}

# Kubernetes Namespace
output "alb_controller_namespace" {
  description = "Namespace where AWS Load Balancer Controller is installed"
  value       = "kube-system"
}
