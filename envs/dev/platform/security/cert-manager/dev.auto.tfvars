project     = "roboshop"
environment = "dev"
aws_region  = "us-east-1"

eks_state_bucket = "roboshop-tf-state"
eks_state_key    = "dev/eks/terraform.tfstate"

letsencrypt_email = "srinivas.jtm@gmail.com"

domain_name = "dev.optimusprime.uno"

enable_qa_cluster_issuer      = false
enable_preprod_cluster_issuer = false
enable_prod_cluster_issuer    = false