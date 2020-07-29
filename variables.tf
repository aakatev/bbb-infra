variable "aws_profile" {
  description = "The AWS profile to use."
  default     = "default"
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

# ubuntu-16.04 (x64) t2.large
variable "aws_amis" {
  default = {
    "us-east-1" = "ami-039a49e70ea773ffc"
    "us-west-2" = "ami-00e3060e4cb84a493"
  }
}

variable "domain_name" {
  description = "Server domain name."
  default     = "example.com"
}

variable "key_path" {
  description = "Path to your SSH key."
  default     = "~/.ssh/id_rsa.pub"
}

variable "volume_size" {
  description = "Volume size in GiB."
  default     = 80
}