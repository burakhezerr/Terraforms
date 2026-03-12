resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name      = "${var.project_name}-cluster"
    User      = var.user
    ManagedBy = "terraform"
  }
}
