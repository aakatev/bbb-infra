variable "aws_ami" {
  description = "EC2 instalnce AMI"
  type        = string
}

variable "domain_name" {
  description = "Server domain name"
  type        = string
}

variable "key_path" {
  description = "Path to your SSH key (public key)"
  type        = string
}

variable "volume_size" {
  description = "Volume size in GiB"
  type        = number
}

data "aws_route53_zone" "bbb_server" {
  name = var.domain_name
}

resource "aws_route53_record" "bbb_server" {
  zone_id = data.aws_route53_zone.bbb_server.zone_id
  name    = "server-1.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.bbb_server.public_ip]
}

resource "aws_eip" "bbb_server" {
  instance = aws_instance.bbb_server.id
  vpc      = true

  tags = {
    terraform = true
  }
}

resource "aws_key_pair" "bbb_server" {
  key_name   = "bbb-key"
  public_key = file(var.key_path)

  tags = {
    terraform = true
  }
}

resource "aws_security_group" "bbb_server" {
  name        = "bbb-server-security-group"
  description = "security group for bbb-server"

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

  ingress {
    from_port   = 16384
    to_port     = 32768
    protocol    = "udp"
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

resource "aws_instance" "bbb_server" {
  instance_type = "t2.large"
  ami           = var.aws_ami

  key_name        = aws_key_pair.bbb_server.key_name
  security_groups = [aws_security_group.bbb_server.name]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = var.volume_size
  }

  tags = {
    terraform = true
  }
}

output "bbb_server_private_ip" {
  value = aws_instance.bbb_server.private_ip
}

output "bbb_server_public_ip" {
  value = aws_eip.bbb_server.public_ip
}