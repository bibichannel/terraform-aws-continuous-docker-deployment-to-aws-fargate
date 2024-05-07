locals {
  stage_map = {
    "prod"    = 0
    "staging" = 1
    "default" = 2
  }

  cidr_block_dot = lookup(local.stage_map, var.stage_name, local.stage_map["default"])
}

###################### Create VPC ##########################

resource "aws_vpc" "vpc" {
  cidr_block           = format("10.%d.0.0/20", local.cidr_block_dot)
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = merge({
    Name = "${var.project_name}-${var.stage_name}"
  }, var.tags)
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  cidr_block              = format("10.%d.1.0/24", local.cidr_block_dot)
  availability_zone       = "${var.aws_region}a"
  tags = merge({
    Name = "${var.project_name}-${var.stage_name}-public-subnet-1"
  }, var.tags)
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  cidr_block              = format("10.%d.2.0/24", local.cidr_block_dot)
  availability_zone       = "${var.aws_region}b"
  tags = merge({
    Name = "${var.project_name}-${var.stage_name}-public-subnet-2"
  }, var.tags)
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = format("10.%d.3.0/24", local.cidr_block_dot)
  availability_zone = "${var.aws_region}a"
  tags = merge({
    Name = "${var.project_name}-${var.stage_name}-private-subnet-1"
  }, var.tags)
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = format("10.%d.4.0/24", local.cidr_block_dot)
  availability_zone = "${var.aws_region}b"
  tags = merge({
    Name = "${var.project_name}-${var.stage_name}-private-subnet-2"
  }, var.tags)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge({
    Name = "${var.project_name}-${var.stage_name}-igw"
  }, var.tags)
}

# resource "aws_eip" "eip" {
#   domain   = "vpc"
#   depends_on = [aws_internet_gateway.igw]
#   tags = merge({
#     Name    = "${var.project_name}-${var.stage_name}-eip"
#   }, var.tags)
# }

# resource "aws_nat_gateway" "natgw" {
#   subnet_id     = aws_subnet.public_subnet_1et-1.id
#   allocation_id = aws_eip.eip.id
#   tags = merge({
#     Name    = "${var.project_name}-${var.stage_name}-natgw"
#   }, var.tags)
# }

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge({
    Name = "${var.project_name}-${var.stage_name}-public-rtb"
  }, var.tags)
}

resource "aws_route_table" "private_rtb_01" {
  vpc_id = aws_vpc.vpc.id
  tags = merge({
    Name = "${var.project_name}-${var.stage_name}-private-rtb-01"
  }, var.tags)
}

resource "aws_route_table" "private_rtb_02" {
  vpc_id = aws_vpc.vpc.id
  tags = merge({
    Name = "${var.project_name}-${var.stage_name}-private-rtb-02"
  }, var.tags)
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
  route_table_id = aws_route_table.private_rtb_01.id
  subnet_id      = aws_subnet.private_subnet_1.id
}

resource "aws_route_table_association" "association-private-subnet-2" {
  route_table_id = aws_route_table.private_rtb_02.id
  subnet_id      = aws_subnet.private_subnet_2.id
}

###################### Create SGs ##########################

resource "aws_security_group" "alb" {
  name        = "${var.project_name}-${var.stage_name}-alb"
  description = "controls access to the ALB"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}


resource "aws_security_group" "ecs_tasks" {
  name        = "${var.project_name}-${var.stage_name}-ecs-tasks"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = var.container_port
    to_port         = var.container_port
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

