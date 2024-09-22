# SSM Endpoint
resource "aws_vpc_endpoint" "ssm_endpoint" {
    vpc_id            = aws_vpc.vpc.id
    service_name      = "com.amazonaws.${var.region}.ssm"
    vpc_endpoint_type = var.vpc_endpoint_type
    subnet_ids        = aws_subnet.private_subnets[*].id
    security_group_ids = [aws_security_group.windows_sg.id] # This is the security group that we created in the previous module for Windows instances

    tags = {
        Name = "${var.project_name}-ssm-endpoint"
    }
}

# SSM Messages Endpoint
resource "aws_vpc_endpoint" "ssmmessages_endpoint" {
    vpc_id            = aws_vpc.vpc.id
    service_name      = "com.amazonaws.${var.region}.ssmmessages"
    vpc_endpoint_type = var.vpc_endpoint_type
    subnet_ids        = aws_subnet.private_subnets[*].id
    security_group_ids = [aws_security_group.windows_sg.id] # This is the security group that we created in the previous module for Windows instances

    tags = {
        Name = "${var.project_name}-ssmmessages-endpoint"
    }
}

# EC2 Messages Endpoint (Session Manager)
resource "aws_vpc_endpoint" "ec2messages_endpoint" {
    vpc_id            = aws_vpc.vpc.id
    service_name      = "com.amazonaws.${var.region}.ec2messages"
    vpc_endpoint_type = var.vpc_endpoint_type
    subnet_ids        = aws_subnet.private_subnets[*].id
    security_group_ids = [aws_security_group.windows_sg.id] # This is the security group that we created in the previous module for Windows instances

    tags = {
        Name = "${var.project_name}-ec2messages-endpoint"
    }
}

