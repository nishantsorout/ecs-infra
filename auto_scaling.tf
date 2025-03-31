resource "aws_autoscaling_group" "ecs_asg" {
  desired_capacity     = var.desired_capacity
  min_size            = var.min_size
  max_size            = var.max_size
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ECS-AutoScaling-Instance"
    propagate_at_launch = true
  }
}




/*
# Attach existing EC2 instance to ASG
resource "aws_autoscaling_attachment" "existing_instance" {
  autoscaling_group_name = aws_autoscaling_group.ecs_asg.name
  instance_id            = "i-xxxxxxxxxxxxx" # Replace with your instance ID
}
*/




## Adding Auto Scaling Group Policies
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.ecs_asg.name
  metric_aggregation_type = "Average"
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.ecs_asg.name
  metric_aggregation_type = "Average"
}
