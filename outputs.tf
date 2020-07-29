output "bbb_server_private_ip" {
  value = aws_instance.bbb_server.private_ip
}

output "bbb_server_public_ip" {
  value = aws_eip.bbb_server.public_ip
}

