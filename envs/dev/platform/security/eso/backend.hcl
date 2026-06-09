bucket         = "roboshop-tf-state"
key            = "dev/platform/security/external-secrets/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "roboshop-tf-locks"
encrypt        = true