resource "aws_security_group" "ecs_security_group" {
  name        = "${var.project_name}-ecs-nginx-sg"
  description = "Security group for the ECS service"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr_block]
  }

  tags = {
    Name       = "${var.project_name}-ecs-nginx-sg"
    ManagedBy  = "terraform"
  }
}
