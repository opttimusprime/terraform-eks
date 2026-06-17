region      = "us-east-1"
project     = "roboshop"
environment = "dev"

eks_state_bucket = "roboshop-tf-state"
eks_state_key    = "dev/eks/terraform.tfstate"

domain_name = "optimusprime.uno"
namespace   = "external-dns"

external_dns_chart_version = "1.15.0"