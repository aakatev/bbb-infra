terraform {
  required_version = ">=0.12.25"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

module "bbb_instance" {
  source = "./modules"

  aws_ami     = var.aws_ami
  domain_name = var.domain_name
  key_path    = var.key_path
  volume_size = var.volume_size
}
