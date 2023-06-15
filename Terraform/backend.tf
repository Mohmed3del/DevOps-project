terraform {
  backend "s3" {
    bucket         = "te1st"
    key            = "devops/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "backend"
  }

}

