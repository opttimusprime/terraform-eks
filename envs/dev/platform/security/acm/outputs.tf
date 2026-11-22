
# ACM Certificate ARN
output "acm_certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate_validation.this.certificate_arn
}

# ACM Certificate Domain
output "acm_certificate_domain" {
  description = "Primary domain of ACM certificate"
  value       = aws_acm_certificate.this.domain_name
}

# Route 53 Hosted Zone ID
output "route53_zone_id" {
  description = "Existing Route 53 public hosted zone ID"
  value       = data.aws_route53_zone.this.zone_id
}

# ACM Certificate Validation Status
output "acm_certificate_status" {
  description = "Current ACM certificate status"
  value       = aws_acm_certificate.this.status
}
