bucket         = "roboshop-tf-state"
#key            = "dev/main.tfstate"
key            = "dev/bootstrap/k8s-workstation/terraform.tfstate"
dynamodb_table = "roboshop-tf-lock"
region         = "us-east-1"
encrypt        = true

