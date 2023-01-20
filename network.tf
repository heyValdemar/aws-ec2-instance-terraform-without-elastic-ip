# VPC creation
resource "aws_vpc" "vpc_1" {
  cidr_block           = var.aws_vpc_1_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "vpc-1"
    Terraform = "true"
  }
}

# Public subnet creation
resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.aws_subnet_1_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.aws_subnet_1_availability_zone

  depends_on = [
    aws_vpc.vpc_1
  ]

  tags = {
    Name      = "public-subnet-1"
    Terraform = "true"
  }
}

# Private subnet creation
resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.vpc_1.id
  cidr_block        = var.aws_subnet_2_cidr_block
  availability_zone = var.aws_subnet_2_availability_zone

  depends_on = [
    aws_vpc.vpc_1
  ]

  tags = {
    Name      = "private-subnet-1"
    Terraform = "true"
  }
}

# Internet gateway creation
resource "aws_internet_gateway" "internet_gateway_1" {
  vpc_id = aws_vpc.vpc_1.id

  depends_on = [
    aws_vpc.vpc_1,
    aws_subnet.subnet_1,
    aws_subnet.subnet_2
  ]

  tags = {
    Name      = "internet-gateway-1"
    Terraform = "true"
  }
}

# Route table creation
resource "aws_route_table" "route_table_1" {
  vpc_id = aws_vpc.vpc_1.id

  # Route configuration
  route {
    cidr_block = var.aws_destination_1_cidr_block
    gateway_id = aws_internet_gateway.internet_gateway_1.id
  }

  depends_on = [
    aws_vpc.vpc_1,
    aws_internet_gateway.internet_gateway_1
  ]

  tags = {
    Name      = "route-table-1"
    Terraform = "true"
  }
}

# Route table association
resource "aws_route_table_association" "public_association_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table_1.id

  depends_on = [
    aws_vpc.vpc_1,
    aws_subnet.subnet_1,
    aws_subnet.subnet_2,
    aws_route_table.route_table_1
  ]
}