
locals {
  acm_validation_records_grouped = {
    for dvo in aws_acm_certificate.this.domain_validation_options :
    dvo.resource_record_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }...
  }

  acm_validation_records = {
    for name, records in local.acm_validation_records_grouped :
    name => records[0]
  }
}
