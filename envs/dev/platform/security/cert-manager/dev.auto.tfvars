project     = "roboshop"
environment = "dev"
aws_region  = "us-east-1"

eks_state_bucket = "roboshop-tf-state"
eks_state_key    = "dev/eks/terraform.tfstate"

cert_manager_namespace     = "cert-manager"
cert_manager_chart_version = "v1.15.3"

letsencrypt_email = "srinivas.jtm@gmail.com"
domain_name       = "dev.optimusprime.uno"

enable_qa_cluster_issuer      = false
enable_preprod_cluster_issuer = false
enable_prod_cluster_issuer    = false