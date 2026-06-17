output "external_dns_role_arn" {
  value = module.external_dns_irsa.iam_role_arn
}

output "route53_zone_id" {
  value = data.aws_route53_zone.this.zone_id
}

output "external_dns_namespace" {
  value = kubernetes_namespace.external_dns.metadata[0].name
}

output "external_dns_service_account" {
  value = kubernetes_service_account.external_dns.metadata[0].name
}

output "external_dns_helm_status" {
  value = helm_release.external_dns.status
}