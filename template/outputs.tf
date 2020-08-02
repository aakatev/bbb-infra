output "bigbluebutton_instance_private_ip" {
  value = module.bigbluebutton_instance.*.private_ip
}

output "bigbluebutton_instance_public_ip" {
  value = module.bigbluebutton_instance.*.public_ip
}

output "scalelite_instance_private_ip" {
  value = module.scalelite_instance.private_ip
}

output "scalelite_instance_public_ip" {
  value = module.scalelite_instance.public_ip
}