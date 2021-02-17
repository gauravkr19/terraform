resource "aws_vpc" "main" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = var.vpc_tag
}

resource "aws_subnet" "public" {
  cidr_block = var.public_subnets
  vpc_id  = aws_vpc.main.id
  map_public_ip_on_launch = "true"
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "rt-public"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}

/*
resource "aws_subnet" "private" {
  cidr_block = var.private_subnets
  vpc_id  = aws_vpc.main.id
  map_public_ip_on_launch = "false"
  tags = {
    Name = "main_pvt"
  }
}
*/


