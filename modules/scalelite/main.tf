variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "aws_ami" {
  description = "EC2 instance AMI"
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

variable "key_path" {
  description = "Path to your SSH key (public key)"
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

resource "aws_key_pair" "scalelite" {
  key_name   = "scalelite-key"
  public_key = file(var.key_path)

  tags = {
    terraform = true
  }
}

resource "aws_security_group" "scalelite" {
  name        = "scalelite-server-security-group"
  description = "Security group for scalelite server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    terraform = true
  }
}

resource "aws_instance" "scalelite" {
  instance_type = var.instance_type
  ami           = var.aws_ami

  key_name        = aws_key_pair.scalelite.key_name
  security_groups = [aws_security_group.scalelite.name]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = var.volume_size
  }

  tags = {
    terraform = true
  }
}

output "scalelite_private_ip" {
  value = aws_instance.scalelite.private_ip
}

output "scalelite_public_ip" {
  value = aws_eip.scalelite.public_ip
}