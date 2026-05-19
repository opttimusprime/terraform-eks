bucket         = "roboshop-tf-state"
#key            = "dev/main.tfstate"
key            = "dev/platform/storage/ebscsi/terraform.tfstate"
dynamodb_table = "roboshop-tf-lock"
region         = "us-east-1"
encrypt        = true

