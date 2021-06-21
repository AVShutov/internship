resource "aws_instance" "ansible" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.primary_public_1.id
  security_groups = [aws_security_group.primary.id]
  key_name      = "frankfurt_key"
  associate_public_ip_address = true
  
  tags = {
    Name = "Ansible"
  }
}

resource "aws_instance" "docker" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  count         = var.docker_count
  subnet_id     = aws_subnet.primary_public_1.id
  security_groups = [aws_security_group.primary.id]
  key_name      = "frankfurt_key"
  associate_public_ip_address = true

  tags = {
    Name = "Docker-${count.index}"
  }
}

/*resource "aws_instance" "docker" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.primary_public_1.id
  security_groups = [aws_security_group.primary.id]
  key_name      = "frankfurt_key"
  user_data     = file("install_docker.sh")
  associate_public_ip_address = true

  tags = {
    Name = "docker"
  }
}*/