resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "${var.service_name}-vpc"
  }
}

resource "aws_subnet" "public_1a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az1
  cidr_block        = var.cidr_public1a
  tags = {
    Name = "${var.service_name}-public-1a"
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az1
  cidr_block        = var.cidr_private1a
  tags = {
    Name = "${var.service_name}-private-1a"
  }
}

resource "aws_subnet" "private_1c" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az2
  cidr_block        = var.cidr_private1c
  tags = {
    Name = "${var.service_name}-private-1c"
  }
}