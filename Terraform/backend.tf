terraform {
  backend "s3" {
    bucket         = "te1st"
    key            = "DevOps/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "backend"
  }

}

