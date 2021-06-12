resource "aws_vpc" "secondary_vpc" {
  cidr_block = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Secondary VPC"
  }
}

#Secondary internet gateway
resource "aws_internet_gateway" "secondary_igw" {
  vpc_id = aws_vpc.secondary_vpc.id
  tags = {
      Name = "Secondary IGW"
  }
}

#Secondary igw route to main route table
resource "aws_route" "secondary-internet_access" {
  route_table_id         = aws_vpc.secondary_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.secondary_igw.id
}

resource "aws_subnet" "secondary_public_1" {
  vpc_id            = aws_vpc.secondary_vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = "172.16.11.0/24"
  tags = {
    Name    = "Public Subnet-1 in ${data.aws_availability_zones.available.names[1]}"
    Account = "Subnet in Account ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.description
  }
}

# Secondary Security Group for Client
resource "aws_security_group" "secondary_client" {
  name = "SSH-Only"
  vpc_id = aws_vpc.secondary_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "SSH-Only"
  }
}
