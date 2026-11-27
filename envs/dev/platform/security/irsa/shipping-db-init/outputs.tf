output "iam_role_name" {
  description = "Shipping DB initialization IAM role name"
  value       = aws_iam_role.shipping_db_init.name
}

output "iam_role_arn" {
  description = "Shipping DB initialization IAM role ARN"
  value       = aws_iam_role.shipping_db_init.arn
}

output "iam_policy_arn" {
  description = "Shipping S3 access IAM policy ARN"
  value       = aws_iam_policy.shipping_s3.arn
}

output "namespace" {
  description = "Kubernetes namespace"
  value       = var.namespace
}

output "service_account_name" {
  description = "Kubernetes ServiceAccount name"
  value       = var.service_account_name
}