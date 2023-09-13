provider "aws" {
  region = var.region

  default_tags {
    tags = { env = local.env }
  }
}


provider "docker" {
  registry_auth {
    address  = local.ecr_address
    password = data.aws_ecr_authorization_token.this.password
    username = data.aws_ecr_authorization_token.this.user_name
  }
}