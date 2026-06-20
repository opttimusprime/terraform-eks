resource "aws_route53_record" "kibana" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "kibana.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.kibana.dns_name
    zone_id                = aws_lb.kibana.zone_id
    evaluate_target_health = true
  }
}