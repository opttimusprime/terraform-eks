bucket         = "roboshop-tf-state"
#key            = "dev/main.tfstate"
key            = "dev/eks/terraform.tfstate"
dynamodb_table = "roboshop-tf-lock"
region         = "us-east-1"
encrypt        = true

