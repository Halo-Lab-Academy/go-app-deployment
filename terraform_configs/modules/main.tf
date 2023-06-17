data "aws_region" "current" {}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-VPC"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "${var.project_name}.eip"
  }
}

resource "aws_nat_gateway" "nat" {

  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element([for subnet_id in aws_subnet.public_subnets : subnet_id.id], 0)

  tags = {
    Name = "${var.project_name}.nat-gw"
  }
  depends_on = [
    aws_internet_gateway.internet_gateway
  ]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-rtb"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-rtb"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat.id
}

resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnet_block

  map_public_ip_on_launch = true
  availability_zone       = each.value.availability_zone
  cidr_block              = each.value.block
  vpc_id                  = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-${each.key}"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnet_block

  map_public_ip_on_launch = true
  availability_zone       = each.value.availability_zone
  cidr_block              = each.value.block
  vpc_id                  = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-${each.key}"
  }
}

resource "aws_route_table_association" "public_subnet_route_table_association" {
  for_each = var.public_subnet_block

  subnet_id      = aws_subnet.public_subnets[each.key].id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table_association" "private_subnet_route_table_association" {
  for_each = var.private_subnet_block

  subnet_id      = aws_subnet.private_subnets[each.key].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "control_plane_security_group" {
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.vpc.id
}

