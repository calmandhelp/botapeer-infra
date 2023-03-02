resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "${var.service_name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.service_name}-igw"
  }
}

resource "aws_subnet" "public_1a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az1
  cidr_block        = var.cidr_public1
  tags = {
    Name = "${var.service_name}-public-1a"
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az1
  cidr_block        = var.cidr_private1
  tags = {
    Name = "${var.service_name}-private-1a"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id            = aws_vpc.vpc.id
  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.service_name}-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_associate" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public_rt.id
}