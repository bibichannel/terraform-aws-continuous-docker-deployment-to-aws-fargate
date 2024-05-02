locals {
  stage_map = {
    "prod"    = 0
    "staging" = 1
    "default" = 2
  }
  
  cidr_block_dot = lookup(local.stage_map, var.stage_name, local.stage_map["default"])
}

resource "aws_vpc" "vpc" {
  cidr_block           = format("10.%d.0.0/20", local.cidr_block_dot)
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-${var.stage_name}"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = format("10.%d.0.0/24", local.cidr_block_dot)
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = format("10.%d.1.0/24", local.cidr_block_dot)
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = format("10.%d.2.0/24", local.cidr_block_dot)
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = format("10.%d.3.0/24", local.cidr_block_dot)
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

# resource "aws_eip" "eip" {
#   tags = {
#     Name = "${var.project_name}-eip"
#   }
# }

# resource "aws_nat_gateway" "natgw" {
#   subnet_id     = aws_subnet.public_subnet_1et-1.id
#   allocation_id = aws_eip.eip.id
#   tags = {
#     Name = "${var.project_name}-natgw"
#   }
# }

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.project_name}-public-rtb"
  }
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-private-rtb"
  }
}

resource "aws_route_table_association" "association-public-subnet-1" {
  route_table_id = aws_route_table.public_rtb.id
  subnet_id      = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "association-public-subnet-2" {
  route_table_id = aws_route_table.public_rtb.id
  subnet_id      = aws_subnet.public_subnet_2.id
}

resource "aws_route_table_association" "association-private-subnet-1" {
  route_table_id = aws_route_table.private_rtb.id
  subnet_id      = aws_subnet.private_subnet_1.id
}

resource "aws_route_table_association" "association-private-subnet-2" {
  route_table_id = aws_route_table.private_rtb.id
  subnet_id      = aws_subnet.private_subnet_2.id
}
