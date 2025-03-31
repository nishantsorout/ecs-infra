# Create Application Load Balancer (ALB)
resource "aws_lb" "ktt_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "KTT-ALB"
  }
}

# Create ALB Listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.ktt_alb.arn
  port              = var.alb_listener_port
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Default 404 - Not Found"
      status_code  = "404"
    }
  }
}

# Create Target Group for Authentication Service
resource "aws_lb_target_group" "auth_tg" {
  name        = var.auth_target_group_name # (target grp name declared in terraform.tfvars)
  port        = var.auth_container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Create Target Group for Booking Service
resource "aws_lb_target_group" "booking_tg" {
  name        = var.booking_target_group_name #(target grp name declared in terraform.tfvars)

  port        = var.booking_container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# ALB Listener Rule for Auth Service
resource "aws_lb_listener" "auth_listener" {
  load_balancer_arn = aws_lb.ktt_alb.arn
  port              = 8080
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.auth_tg.arn
  }
}

# ALB Listener Rule for Booking Service
resource "aws_lb_listener" "booking_listener" {
  load_balancer_arn = aws_lb.ktt_alb.arn
  port              = 8082
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.booking_tg.arn
  }
}


