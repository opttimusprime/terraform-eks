
# Fetch existing Route 53 Public Hosted Zone
data "aws_route53_zone" "this" {
  name         = "${var.domain_name}."
  private_zone = false
}
