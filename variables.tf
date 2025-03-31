variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "ECS cluster"
  type = string
}

variable "instance_id" {
  description = "Existing EC2 instance ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC where ECS will run"
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet IDs for ALB and ECS"
  type        = list(string)
}


variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}


variable "ecs_security_group_id" {
  description = "Security group ID for ECS"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID for ALB"
  type        = string
}

variable "ecs_service_auth_name" {
  description = "ECS Service name for Authentication"
  type        = string
  default     = "backend-auth-service"
}

variable "ecs_service_booking_name" {
  description = "ECS Service name for Booking"
  type        = string
  default     = "backend-booking-service"
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}

variable "alb_listener_port" {
  description = "Port for ALB listener (e.g., 80 for HTTP, 443 for HTTPS)"
  type        = number
}

variable "auth_target_group_name" {
  description = "The name of the authentication target group"
  type        = string
}

variable "auth_container_port" {
  description = "Port for the authentication container"
  type        = number
}

variable "booking_target_group_name" {
  description = "The name of the booking target group"
  type        = string
}

variable "booking_container_port" {
  description = "Port for the booking container"
  type        = number
}





## Attaching Auto Scaling Group to ECS
variable "ami_id" {
  description = "AMI ID for ECS-optimized Amazon Linux 2"
  default     = "ami-076c6dbba59aa92e6"  # Replace with the latest ECS-optimized AMI
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key for EC2 access"
  default     = "ktt-kp"
}

variable "ecs_cluster_name" {
  description = "ECS Cluster name"
  default     = "ktt"
}

variable "ecr_url" {
  description = "ECR repository URL"
  default     = "418295676733.dkr.ecr.ap-south-1.amazonaws.com"
}

variable "desired_capacity" {
  description = "Desired number of ECS instances"
  default     = 0
}

variable "min_size" {
  description = "Minimum number of ECS instances"
  default     = 0
}

variable "max_size" {
  description = "Maximum number of ECS instances"
  default     = 3
}

variable "ASG_security_group_id" {
  description = "security group for ASG"
  type        = list(string)
}
