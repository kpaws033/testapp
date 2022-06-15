provider "aws" {
  region = local.region
}

locals {
  region = "eu-west-2"
}

provider "aws" {
  access_key = "AKIA5PNF3D6Z5WJRQUUJ"
  secret_key = "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"
  region     = var.aws_region
  #if you are running from AWS ec2 linux instance please use bellow credentials section
  #shared_credentials_file = "$HOME/.aws/credentials"
  #profile = "default"
}

