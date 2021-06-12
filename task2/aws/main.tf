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

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

#Establishes a relationship resource between the "primary" and "secondary" VPC.
resource "aws_vpc_peering_connection" "primary2secondary" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = aws_vpc.secondary_vpc.id
  vpc_id        = aws_vpc.primary_vpc.id
  auto_accept   = true
}

/**
 * Route rule.
 *
 * Creates a new route rule on the "primary" VPC main route table. All requests
 * to the "secondary" VPC's IP range will be directed to the VPC peering
 * connection.
 */
resource "aws_route" "primary2secondary" {
  route_table_id            = aws_vpc.primary_vpc.main_route_table_id
  destination_cidr_block    = aws_vpc.secondary_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.primary2secondary.id
}

/**
 * Route rule.
 *
 * Creates a new route rule on the "secondary" VPC main route table. All
 * requests to the "secondary" VPC's IP range will be directed to the VPC
 * peering connection.
 */
resource "aws_route" "secondary2primary" {
  route_table_id            = aws_vpc.secondary_vpc.main_route_table_id
  destination_cidr_block    = aws_vpc.primary_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.primary2secondary.id
}
