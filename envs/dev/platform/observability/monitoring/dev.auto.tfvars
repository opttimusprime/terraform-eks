aws_region           = "us-east-1"
project              = "roboshop"
environment          = "dev"
remote_state_bucket  = "roboshop-tf-state"

domain_name          = "optimusprime.uno"
acm_certificate_arn  = "arn:aws:acm:us-east-1:942548380129:certificate/04035cfa-147e-46be-aca6-93361d8a3c0b"
allowed_ingress_cidr = "0.0.0.0/0"
grafana_admin_password = "Admin@12345"