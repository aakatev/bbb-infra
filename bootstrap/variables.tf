variable "aws_profile" {
  description = "The AWS profile to use"
  default     = "default"
}

variable "aws_region" {
  description = "The AWS region to provision resources in"
  default     = "us-east-1"
}

variable "key_name" {
  description = "Name for your SSH public key"
  default     = "bigbluebutton"
}

variable "key_path" {
  description = "Path to your SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "bigbluebutton_security_group_name" {
  description = "Name fo bigbluebutton security group"
  default     = "bigbluebutton-security-group"
}

variable "scalelite_security_group_name" {
  description = "Name fo scalelite security group"
  default     = "scalelite-security-group"
}