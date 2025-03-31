aws_region      = "ap-south-1"

# AWS Credentials (Only if not using an IAM role for Terraform)
aws_access_key  = "AKIAWCZC5P466Z76UXDK"
aws_secret_key  = "kvRwGG6RRfKEKdEPP9Qw+9WNTJ9O1Xh8hbeIwtEp"

# ECS Cluster & EC2 Details
cluster_name    = "ktt"
instance_id     = "i-094197923b495d358"  # Replace with your actual EC2 instance ID

# Networking Variables
vpc_id         = "vpc-04ea548448f8b10c8"  # Replace with your actual VPC ID
subnet_ids     = ["subnet-020940a277de12326","subnet-0f16f54f1bb57725d"]  #requested instance type (t2.micro) is not supported in your requested Availability Zone (ap-south-1c) that is "subnet-0b3e0ac874ce56500"

# AWS Account Details
aws_account_id = "418295676733"

# Security Groups
ASG_security_group_id = ["sg-04159d55c55f06c72"]
alb_security_group_id = "sg-04159d55c55f06c72"  # Replace with actual ALB security group ID
ecs_security_group_id = "sg-04159d55c55f06c72"  # Replace with actual ECS security group ID

#application load balancer 
alb_name = "ktt-alb"

#target group names
auth_target_group_name = "auth-tg"
booking_target_group_name= "booking-tg"

#container ports
auth_container_port = "8080"  # Port for authentication service
booking_container_port = "8082" # Port for booking service
alb_listener_port = "80" #Listener port for ALB