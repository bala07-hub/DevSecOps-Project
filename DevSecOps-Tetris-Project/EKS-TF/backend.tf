terraform {
  backend "s3" {
    bucket       = "dev-bala-tf-bucket"
    region       = "us-east-1"
    key          = ""
    use_lockfile = true
    encrypt      = true
  }
  required_version = ">=1.14.0"
  required_providers {
    aws = {
      version = ">= 5.49.0"
      source  = "hashicorp/aws"
    }
  }
}
