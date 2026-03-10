resource "aws_iam_role" "ecs_exec_role" {
    name = "${var.project_name}-ecs-exec-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = {
                Service = "ecs-tasks.amazonaws.com"
            }
            Action = "sts:AssumeRole"
        }]
    })

    tags = merge({
        Name = "${var.project_name}-ecs-exec-role"
        User = "Burak"
        created_by = "Terraform"
    })
}

resource "aws_iam_policy_attachment" "ecs_exec_role_policy_ecs" {
    name       = "ecs_exec_role_policy_ecs"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
    roles      = [aws_iam_role.ecs_exec_role.name]
}

resource "aws_iam_policy_attachment" "ecs_exec_role_policy_logs" {
    name       = "ecs_exec_role_policy_logs"
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    roles      = [aws_iam_role.ecs_exec_role.name]
}

resource "aws_iam_role" "ecs_task_role" {
    name = "${var.project_name}-ecs-task-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = {
                Service = "ecs-tasks.amazonaws.com"
            }
            Action = "sts:AssumeRole"
        }]
    })

    tags = merge({
        Name = "${var.project_name}-ecs-task-role"
        User = "Burak"
        created_by = "Terraform"
    })
}

resource "aws_iam_policy_attachment" "ecs_task_role_policy_ssm" {
    name       = "ecs_task_role_policy_ssm"
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    roles      = [aws_iam_role.ecs_task_role.name]
}

resource "aws_iam_policy_attachment" "ecs_task_role_policy_ecr" {
    name       = "ecs_task_role_policy_ecr"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    roles      = [aws_iam_role.ecs_task_role.name]
}