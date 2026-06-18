output "external_secrets_role_arn" {
  value = module.external_secrets_irsa.iam_role_arn
}

output "external_secrets_namespace" {
  value = local.namespace
}

output "external_secrets_service_account" {
  value = local.service_account_name
}