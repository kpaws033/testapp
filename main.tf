provider "aws" {
  region = local.region
}

locals {
  region = "eu-west-2"
}

provider "aws" {
  access_key = "XX"
  secret_key = "XX"
  region     = var.aws_region
  #if you are running from AWS ec2 linux instance please use bellow credentials section
  #shared_credentials_file = "$HOME/.aws/credentials"
  #profile = "default"
}

