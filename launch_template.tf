resource "aws_launch_template" "ecs_launch_template" {
  name          = "ecs-launch-template"
  image_id      = var.ami_id  
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.ASG_security_group_id # Use the existing security group
  }


  user_data = base64encode(<<EOF
#!/bin/bash
# Update system and install required packages
yum update -y
yum install -y docker git unzip

# Start Docker service
systemctl start docker
systemctl enable docker

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Log in to Amazon ECR
aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${var.ecr_url}

# Pull and run the Docker container
docker pull ${var.ecr_url}/your-image:latest
docker run -d -p 80:80 ${var.ecr_url}/your-image:latest

# Register instance to ECS Cluster
echo "ECS_CLUSTER=${var.cluster_name}" >> /etc/ecs/ecs.config

# Restart ECS agent
systemctl restart ecs
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ECS-AutoScaling-Instance"
    }
  }
}


/* 

# If we have an ami id, then we can directly create an ASG from it; no need to define a separate launch template
resource "aws_launch_template" "ecs_launch_template" {
  name_prefix   = "ecs-instance"
  image_id      = "ami-xxxxxxxxxxxxxxxxx"  # Replace with your new AMI ID
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.ASG_security_group_id
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ECS-Instance"
    }
  }
}

*/