variable "aws_profile" {
  description = "The AWS profile to use"
  default     = "default"
}

variable "aws_region" {
  description = "The AWS region to provision resources in"
  default     = "us-east-1"
}

variable "key_path" {
  description = "Path to your SSH public key (shared)"
  default     = "~/.ssh/id_rsa.pub"
}

variable "bigbluebutton_instance_type" {
  description = "EC2 instance type (bigbluebutton)"
  default     = "t2.large"
}

variable "bigbluebutton_aws_ami" {
  description = "EC2 instalnce AMI (bigbluebutton)"
  default     = "ami-039a49e70ea773ffc"
}

variable "bigbluebutton_domain_name" {
  description = "Server domain name (bigbluebutton)"
  default     = "example.com"
}

variable "bigbluebutton_subdomain_name" {
  description = "Server subdomain name (bigbluebutton)"
  default     = null
}

variable "bigbluebutton_volume_size" {
  description = "Volume size in GiB (bigbluebutton)"
  default     = 80
}

variable "scalelite_instance_type" {
  description = "EC2 instance type (scalelite)"
  default     = "t3.medium"
}

variable "scalelite_aws_ami" {
  description = "EC2 instance AMI (scalelite)"
  default     = "ami-07df16d0682f1fa59"
}

variable "scalelite_domain_name" {
  description = "Server domain name (scalelite)"
  default     = "example.com"
}

variable "scalelite_subdomain_name" {
  description = "Server subdomain name (scalelite)"
  default     = null
}

variable "scalelite_volume_size" {
  description = "Volume size in GiB (scalelite)"
  default     = 50
}