resource "aws_ecs_service" "backend_auth_service" {
  name            = var.ecs_service_auth_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.backend_auth_task.arn
  desired_count   = 1
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.auth_tg.arn
    container_name   = "backend-auth-container"
    container_port   = var.auth_container_port
  }
}

resource "aws_ecs_service" "backend_booking_service" {
  name            = var.ecs_service_booking_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.backend_booking_task.arn
  desired_count   = 1
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.booking_tg.arn
    container_name   = "backend-booking-container"
    container_port   = var.booking_container_port
  }
}


