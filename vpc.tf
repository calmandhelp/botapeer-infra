resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc1"
  }
}

resource "aws_subnet" "public_1a" {
  vpc_id = aws_vpc.vpc1.id
  availability_zone = "ap-northeast-1a"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "botapeer-public-1a"
  }
}