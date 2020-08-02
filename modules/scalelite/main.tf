variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "aws_ami" {
  description = "EC2 instance AMI"
  type        = string
}

variable "security_group_name" {
  description = "Name for security group"
  type        = string
}

variable "domain_name" {
  description = "Server domain name"
  type        = string
}

variable "subdomain_name" {
  description = "Server subdomain name"
  type        = any
}

variable "key_name" {
  description = "Name for your SSH public key"
  type        = string
}

variable "volume_size" {
  description = "Volume size in GiB"
  type        = number
}

data "aws_route53_zone" "scalelite" {
  name = var.domain_name
}

resource "aws_route53_record" "scalelite" {
  zone_id = data.aws_route53_zone.scalelite.zone_id
  name    = ((var.subdomain_name == null) ? var.domain_name : "${var.subdomain_name}.${var.domain_name}")
  type    = "A"
  ttl     = "300"
  records = [aws_eip.scalelite.public_ip]
}

resource "aws_eip" "scalelite" {
  instance = aws_instance.scalelite.id
  vpc      = true

  tags = {
    terraform = true
  }
}

resource "aws_instance" "scalelite" {
  instance_type = var.instance_type
  ami           = var.aws_ami

  key_name        = var.key_name
  security_groups = [var.security_group_name]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = var.volume_size
  }

  tags = {
    terraform = true
  }
}

output "private_ip" {
  value = aws_instance.scalelite.private_ip
}

output "public_ip" {
  value = aws_eip.scalelite.public_ip
}