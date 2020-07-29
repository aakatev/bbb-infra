provider "aws" {
  profile = var.aws_profile
  region = var.aws_region
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
  ami = var.aws_amis[var.aws_region]

  key_name = aws_key_pair.bbb_server.key_name
  security_groups = [aws_security_group.bbb_server.name]
  
  user_data = file("userdata.sh")

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = var.volume_size
  }

  tags = {
    terraform = true
  }
}

