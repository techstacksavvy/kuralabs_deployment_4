output "private_instance_id" {
    value = aws_instance.web_server2.id
}

output "public_instance_public_ip" {
    value = aws_instance.web_server1.public_ip
  }

output "aws_security_group" {
    value = aws_security_group.web_ssh.id
}