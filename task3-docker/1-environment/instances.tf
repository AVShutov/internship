/*resource "aws_instance" "web" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.primary_public_1.id
  security_groups = [aws_security_group.primary_web.id]
  key_name      = "frankfurt_key"
  user_data     = file("client_data.sh")
  associate_public_ip_address = true


  tags = {
    Name = "WebServer"
  }
}*/

resource "aws_instance" "docker" {
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
}