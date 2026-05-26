data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "roboshop-tf-state"
    key    = "dev/eks/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "storageclass" {
  backend = "s3"

  config = {
    bucket = "roboshop-tf-state"
    key    = "dev/platform/storage/storageclass/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "namespace" {
  backend = "s3"

  config = {
    bucket = "roboshop-tf-state"
    key    = "dev/platform/namespaces/mongodb/terraform.tfstate"
    region = "us-east-1"
  }
}