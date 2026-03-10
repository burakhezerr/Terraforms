resource "aws_vpc" "vpc" {
    cidr_block           = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = merge(
        var.default_tags,
        { 
            Name = "${var.project_name}-vpc" 
        }
    )
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = merge(
        var.default_tags,
        { 
            Name = "${var.project_name}-vpc-igw" 
        }
    )
}

resource "aws_subnet" "public_subnets" {
    for_each          = { for idx, az in var.azs : az => idx if idx < var.subnet_count }
    availability_zone = each.key
    cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 2 * each.value)
    vpc_id            = aws_vpc.vpc.id
    tags = merge(
        var.default_tags,
        { 
            Name = "${var.project_name}-public-subnet-${each.value + 1}"
        }
    )
}

# resource "aws_subnet" "private_subnets" {
#     for_each          = { for idx, az in var.azs : az => idx if idx < var.subnet_count }
#     availability_zone = each.key
#     cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 2 * each.value + 1)
#     vpc_id            = aws_vpc.vpc.id
#     tags = merge(
#         var.default_tags,
#         { 
#             Name = "${var.project_name}-private-subnet-${each.value + 1}"
#         }
#     )
# }

# # These elastic IPs is for NAT Gateways
# resource "aws_eip" "eips" { 
#     for_each = { for idx, az in var.azs : az => idx if idx < var.subnet_count }
#     depends_on = [
#         aws_internet_gateway.igw
#     ]
#     tags = merge(
#         var.default_tags,
#         { 
#             Name = "${var.project_name}-eIP-${each.value + 1}"
#         }
#     )
# }

# resource "aws_nat_gateway" "nat_gateways" {
#     for_each      = { for idx, az in var.azs : az => idx if idx < var.subnet_count }
#     allocation_id = aws_eip.eips[each.key].id
#     subnet_id     = aws_subnet.public_subnets[each.key].id
#     tags = merge(
#         var.default_tags,
#         { 
#             Name = "${var.project_name}-NAT-Gateway-${each.value + 1}"
#         }
#     )
# }

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = merge(
        var.default_tags,
        { 
            Name = "${var.project_name}-public-route-table"
        }
    )
}

# resource "aws_route_table" "private_route_tables" {
#     for_each = { for idx, az in var.azs : az => idx if idx < var.subnet_count }
#     vpc_id   = aws_vpc.vpc.id
#     route {
#         cidr_block     = "0.0.0.0/0"
#         nat_gateway_id = aws_nat_gateway.nat_gateways[each.key].id
#     }
#     tags = merge(   
#         var.default_tags,
#         { 
#             Name = "${var.project_name}-private-route-table-${each.key}"
#         }
#     )
# }

resource "aws_route_table_association" "public_table_association" {
    for_each       = { for idx, az in var.azs : az => idx if idx < var.subnet_count}
    route_table_id = aws_route_table.public_route_table.id
    subnet_id      = aws_subnet.public_subnets[each.key].id
}

# resource "aws_route_table_association" "private_table_association" {
#     for_each       = { for idx, az in var.azs : az => idx if idx < var.subnet_count }
#     route_table_id = aws_route_table.private_route_tables[each.key].id
#     subnet_id      = aws_subnet.private_subnets[each.key].id
# }