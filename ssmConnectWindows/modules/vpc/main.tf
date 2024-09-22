resource "aws_vpc" "vpc" {
    cidr_block           = var.cidr_block
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = merge(
        { Name = "${var.project_name}-vpc" }
    )
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = merge(
        { Name = "${var.project_name}-igw" }
    )
}


resource "aws_subnet" "public_subnets" {
    availability_zone       = "${var.region}${element(var.azs, count.index)}"
    cidr_block              = element(var.public_subnet_cidrs, count.index)
    count                   = var.subnet_count
    vpc_id                  = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-public-subnet-${count.index + 1}"
    }
}

resource "aws_subnet" "private_subnets" {
    availability_zone = "${var.region}${element(var.azs, count.index)}"
    cidr_block        = element(var.private_subnet_cidrs, count.index)
    count             = var.subnet_count
    vpc_id            = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-private-subnet-${count.index + 1}"
    }
}

resource "aws_eip" "eips" {
    count = var.subnet_count
    depends_on = [
        aws_internet_gateway.igw
    ]
    tags = merge(
        { Name = "${var.project_name}-eIP-${count.index + 1}" }
    )
}
resource "aws_nat_gateway" "nat_gateways" {
    allocation_id = aws_eip.eips[count.index].id
    count         = var.subnet_count
    subnet_id     = aws_subnet.public_subnets[count.index].id
    tags = merge(
        { Name = "${var.project_name}-NAT-gateway-${count.index + 1}" }
    )
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = merge(
        { Name = "${var.project_name}-public-route-table" }
    )
}

resource "aws_route_table" "private_route_tables" {
    count  = var.subnet_count
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateways[count.index].id
    }
    tags = merge(
        { Name = "${var.project_name}-private-route-table-${count.index + 1}" }
    )
}

resource "aws_route_table_association" "public_table_association" {
    count          = var.subnet_count
    route_table_id = aws_route_table.public_route_table.id
    subnet_id      = aws_subnet.public_subnets[count.index].id
}

resource "aws_route_table_association" "private_table_association" {
    count          = var.subnet_count
    route_table_id = aws_route_table.private_route_tables[count.index].id
    subnet_id      = aws_subnet.private_subnets[count.index].id
}

# Security groups

resource "aws_security_group" "windows_sg" {
    description = "${var.project_name} windows sg"
    name        = "${var.project_name}-windows-sg"
    vpc_id      = aws_vpc.vpc.id

    ingress {
        description = "Allow RDP traffic from anywhere"
        from_port   = 3389
        to_port     = 3389
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # We can restrict this to a specific IP range
    }

    ingress {
        description = "Allow HTTPS traffic from anywhere"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # It allows HTTPS traffic for Windows instances SSM
    }
    egress {
        description = "Allow all traffic out"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.project_name}-windows-sg"
    }
}

