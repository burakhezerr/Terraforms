resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  count = var.alarms_enable ? 1 : 0

  alarm_name          = "${var.ecs_cluster_name}-${var.application_name}-cpu-utilization-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "Monitors CPU utilization for ${var.application_name}"

  dimensions = {
    ClusterName = var.ecs_cluster_name
  }

  tags = {
    ManagedBy = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_utilization_alarm" {
  count = var.alarms_enable ? 1 : 0

  alarm_name          = "${var.ecs_cluster_name}-${var.application_name}-memory-utilization-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.memory_threshold
  alarm_description   = "Monitors memory utilization for ${var.application_name}"

  dimensions = {
    ClusterName = var.ecs_cluster_name
  }

  tags = {
    ManagedBy = "terraform"
  }
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/${var.project_name}/${var.application_name}"
  retention_in_days = 7

  tags = {
    ManagedBy = "terraform"
  }
}
