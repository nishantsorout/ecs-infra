resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 60
  statistic          = "Average"
  threshold          = 70  # If CPU usage > 70%, trigger scale-up
  alarm_actions      = [aws_autoscaling_policy.scale_up.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ecs_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "low-cpu-usage"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 60
  statistic          = "Average"
  threshold          = 30  # If CPU usage < 30%, trigger scale-down
  alarm_actions      = [aws_autoscaling_policy.scale_down.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ecs_asg.name
  }
}
