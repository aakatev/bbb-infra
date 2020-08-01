terraform {
  required_version = ">=0.12.25"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

module "bigbluebutton_instance" {
  source = "./modules/bigbluebutton"

  key_path = var.key_path

  instance_type  = var.bigbluebutton_instance_type
  aws_ami        = var.bigbluebutton_aws_ami
  domain_name    = var.bigbluebutton_domain_name
  subdomain_name = var.bigbluebutton_subdomain_name
  volume_size    = var.bigbluebutton_volume_size
}

module "scalelite_instance" {
  source = "./modules/scalelite"

  key_path = var.key_path

  instance_type  = var.scalelite_instance_type
  aws_ami        = var.scalelite_aws_ami
  domain_name    = var.scalelite_domain_name
  subdomain_name = var.scalelite_subdomain_name
  volume_size    = var.scalelite_volume_size
}