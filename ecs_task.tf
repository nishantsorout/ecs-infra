resource "aws_ecs_task_definition" "backend_auth_task" {
  family                   = "backend-auth-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  memory                   = "512"
  cpu                      = "256"

  container_definitions = jsonencode([
    {
      name      = "backend-auth-container"
      image     = "${aws_ecr_repository.backend_auth.repository_url}:${var.image_tag}"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "backend_booking_task" {
  family                   = "backend-booking-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  memory                   = "512"
  cpu                      = "256"

  container_definitions = jsonencode([
    {
      name      = "backend-booking-container"
      image     = "${aws_ecr_repository.backend_booking.repository_url}:${var.image_tag}"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8082
          hostPort      = 80
        }
      ]
    }
  ])
}



