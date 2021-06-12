resource "aws_instance" "web" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.primary_public_1.id
  security_groups = [aws_security_group.primary_web.id]
  key_name      = "frankfurt_key"
  user_data     = file("client_data.sh")
  associate_public_ip_address = true

/*
  provisioner "file" {
    source      = "~/.ssh/frankfurt_key.pem"
    destination = "/home/ec2-user/.ssh/frankfurt_key.pem"

    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("~/.ssh/frankfurt_key.pem")}"
    }
  }*/

  tags = {
    Name = "WebServer"
  }
}

resource "aws_instance" "client" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.secondary_public_1.id
  security_groups = [aws_security_group.secondary_client.id]
  key_name      = "frankfurt_key"
  associate_public_ip_address = true

/*
  provisioner "file" {
    source      = "~/.ssh/frankfurt_key.pem"
    destination = "/home/ubuntu/.ssh/frankfurt_key.pem"

    connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file("~/.ssh/frankfurt_key.pem")}"
    }
  }*/

  tags = {
    Name = "Client"
  }
}