# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "tf-rs-internship"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "my_vpcs" {}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "null_resource" "ansible_install" {

  provisioner "file" {
    source      = "~/.ssh/frankfurt_key.pem"
    destination = "~/.ssh/frankfurt_key.pem"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host = aws_instance.ansible.public_dns
#      host        = "${self.public_ip}"
      private_key = "${file("~/.ssh/frankfurt_key.pem")}"
      timeout     = "20s"
      agent       = false
    }
  }

  provisioner "file" {
    source      = "~/.aws"
    destination = "~/.aws"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host = aws_instance.ansible.public_dns
#      host        = "${self.public_ip}"
      private_key = "${file("~/.ssh/frankfurt_key.pem")}"
      timeout     = "20s"
      agent       = false
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y curl git mc",
      "pip3 install --user ansible paramiko docker-compose boto3 botocore",
      "ansible-galaxy collection install amazon.aws",
      "ansible-galaxy collection install community.docker",
      "ansible-galaxy collection install ansible.posix",
      "git clone https://github.com/AVShutov/internship.git",
      "sudo chmod 400 ~/.ssh/frankfurt_key.pem"
#      "ansible-playbook /tmp/ans_ws/site.yaml"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
#      host        = "${self.public_ip}"
      host = aws_instance.ansible.public_dns
      private_key = "${file("~/.ssh/frankfurt_key.pem")}"
      timeout     = "20s"
      agent       = false
    }
  }
}
