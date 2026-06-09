output "external_dns_role_arn" {
  value = module.external_dns_irsa.iam_role_arn
}

output "route53_zone_id" {
  value = data.aws_route53_zone.this.zone_id
}