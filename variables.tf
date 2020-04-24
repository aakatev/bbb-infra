variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

# ubuntu-16.04 (x64)
variable "aws_amis" {
  default = {
    "us-east-1" = "ami-039a49e70ea773ffc"
    "us-west-2" = "ami-00e3060e4cb84a493"
  }
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
}

