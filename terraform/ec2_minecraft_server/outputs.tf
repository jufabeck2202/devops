output "DNS" {
  value = aws_instance.minecraft_server.public_dns
}
output "ip" {
  value = aws_instance.minecraft_server.public_ip
}
