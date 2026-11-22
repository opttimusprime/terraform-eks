
# 1. Request ACM Public Certificate
resource "aws_acm_certificate" "this" {
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  subject_alternative_names = (
    var.create_root_domain_certificate
    ? [var.domain_name]
    : []
  )

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.project}-${var.environment}-wildcard-acm"
  }
}

# 2. Create Route 53 DNS Validation Records
resource "aws_route53_record" "validation" {
  for_each = local.acm_validation_records

  zone_id = data.aws_route53_zone.this.zone_id

  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]

  allow_overwrite = true
}

# 3. Wait for ACM Certificate Validation
resource "aws_acm_certificate_validation" "this" {
  certificate_arn = aws_acm_certificate.this.arn

  validation_record_fqdns = [
    for record in aws_route53_record.validation :
    record.fqdn
  ]
}
