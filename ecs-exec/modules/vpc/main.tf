resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "${var.project_name}-vpc"
    ManagedBy = "terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name      = "${var.project_name}-igw"
    ManagedBy = "terraform"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each          = { for idx, az in var.azs : az => idx if idx < var.subnet_count }
  availability_zone = each.key
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 2 * each.value)
  vpc_id            = aws_vpc.vpc.id

  tags = {
    Name      = "${var.project_name}-public-subnet-${each.value + 1}"
    ManagedBy = "terraform"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name      = "${var.project_name}-public-route-table"
    ManagedBy = "terraform"
  }
}

resource "aws_route_table_association" "public_table_association" {
  for_each       = { for idx, az in var.azs : az => idx if idx < var.subnet_count }
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnets[each.key].id
}
