##### AWS EC2 INSTANCE

resource "aws_instance" "webserver" {
  instance_type = var.instance_type
  ami           = var.ami_id
  key_name = aws_key_pair.key_tf.key_name
  vpc_security_group_ids = ["${aws_security_group.sg_tf.id}"]
  provisioner "remote-exec" {
    script = "./script.sh"
    connection {
      type = "ssh"
      user = "ec2-user"
      host = self.public_ip
      private_key = file("${path.module}/id_rsa")
    }

    
  }

}


### KEY_PAIR #####

resource "aws_key_pair" "key_tf" {
  key_name   = "tf-key"
  public_key = file("${path.module}/id_rsa.pub")

}

### SECURITY GROUP ###
resource "aws_security_group" "sg_tf" {
  name        = "sg_group"
  description = "this is project with jenkins"
  dynamic "ingress" {
    for_each = [22, 80, 443]
    iterator = port
    content {
      description = "TLS to VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}