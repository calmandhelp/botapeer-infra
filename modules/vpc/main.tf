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