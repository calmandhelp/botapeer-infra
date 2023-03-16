resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc
  enable_dns_hostnames = true
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

resource "aws_subnet" "public_1c" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az2
  cidr_block        = var.cidr_public1c
  tags = {
    Name = "${var.service_name}-public-1c"
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

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.ap-northeast-1.secretsmanager"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1c.id
   ]
  security_group_ids = [ aws_security_group.vpc_endpoint_sg.id ]
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1c.id
   ]
  security_group_ids = [ aws_security_group.vpc_endpoint_sg.id ]
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1c.id
   ]
  security_group_ids = [ aws_security_group.vpc_endpoint_sg.id ]
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.ap-northeast-1.logs"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1c.id
   ]
  security_group_ids = [ aws_security_group.vpc_endpoint_sg.id ]
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1c.id
   ]
  security_group_ids = [ aws_security_group.vpc_endpoint_sg.id ]
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1c.id
   ]
  security_group_ids = [ aws_security_group.vpc_endpoint_sg.id ]
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.ap-northeast-1.s3"
  route_table_ids = [ 
    aws_route_table.private_rt.id,
  ]
}