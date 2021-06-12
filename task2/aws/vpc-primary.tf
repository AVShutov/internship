resource "aws_vpc" "primary_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Primary VPC"
  }
}

#Primary internet gateway
resource "aws_internet_gateway" "primary_igw" {
  vpc_id = aws_vpc.primary_vpc.id
  tags = {
      Name = "Primary IGW"
  }
}

#Primary igw route to main route table
resource "aws_route" "primary-internet_access" {
  route_table_id         = aws_vpc.primary_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.primary_igw.id
}

resource "aws_subnet" "primary_public_1" {
  vpc_id            = aws_vpc.primary_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.0.11.0/24"
  tags = {
    Name    = "Public Subnet-1 in ${data.aws_availability_zones.available.names[0]}"
    Account = "Subnet in Account ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.description
  }
}

#Primary Security Group for WebServer
resource "aws_security_group" "primary_web" {
  name = "Dynamic Security Group"
  vpc_id = aws_vpc.primary_vpc.id

  dynamic "ingress" {
    for_each = ["80", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
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

  tags = {
    Name  = "HTTP-SSH"
  }
}