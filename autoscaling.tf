# Adding autoscaling to EC2 instances in public subnet

# Create launch template
resource "aws_launch_template" "public_launch_template" {
  name                   = "public_launch_template"
  image_id               = data.aws_ami.latest_linux_ami.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  # user_data             = file("mariadb-setup.sh")
  user_data = base64encode(data.template_file.user-data.rendered)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "asg-dev-instance"
    }
  }
}

# Create autoscaling group
resource "aws_autoscaling_group" "public_asg" {
  name                      = "public_asg"
  min_size                  = 1
  max_size                  = 4
  desired_capacity          = 2
  vpc_zone_identifier       = [aws_subnet.public-1.id, aws_subnet.public-2.id]
  target_group_arns         = [aws_lb_target_group.target-group.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "DevASGInstance"
    value               = "Dev"
    propagate_at_launch = true
  }

  launch_template {
    id      = aws_launch_template.public_launch_template.id
    version = "$Latest"
  }
}

# Create autoscaling policy
resource "aws_autoscaling_policy" "public_asg_policy" {
  name                   = "public_asg_policy"
  autoscaling_group_name = aws_autoscaling_group.public_asg.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}