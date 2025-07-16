output "aws_security_group" {
    value = aws_security_group.sg_tf.id
  
}

output "public_key" {
    value = aws_instance.webserver.public_ip
  
}