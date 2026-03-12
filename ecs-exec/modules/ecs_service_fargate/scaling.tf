resource "aws_appautoscaling_target" "ecs_scaling_target" {
  count = var.scaling_enable ? 1 : 0

  max_capacity       = var.max_task_capacity
  min_capacity       = var.min_task_capacity
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [aws_ecs_service.ecs_service]

  tags = {
    Name      = "${var.ecs_cluster_name}-${aws_ecs_service.ecs_service.name}-target"
    ManagedBy = "terraform"
  }
}

resource "aws_appautoscaling_policy" "ecs_cpu_scaling_policy" {
  count = (var.scaling_enable && var.scaling_cpu_enable) ? 1 : 0

  name               = "${var.ecs_cluster_name}-${aws_ecs_service.ecs_service.name}-cpu-scale-out"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_scaling_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_scaling_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_scaling_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = var.scaling_cpu_target_value
  }

  depends_on = [aws_appautoscaling_target.ecs_scaling_target]
}

resource "aws_appautoscaling_policy" "ecs_memory_scaling_policy" {
  count = (var.scaling_enable && var.scaling_memory_enable) ? 1 : 0

  name               = "${var.ecs_cluster_name}-${aws_ecs_service.ecs_service.name}-memory-scale-out"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_scaling_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_scaling_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_scaling_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = var.scaling_memory_target_value
  }

  depends_on = [aws_appautoscaling_target.ecs_scaling_target]
}
