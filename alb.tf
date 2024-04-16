# Adding Application Load Balancer

# Create an ALB
resource "aws_lb" "alb" {
  name               = "jonnie-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public-1.id, aws_subnet.public-2.id]
  security_groups    = [aws_security_group.alb-sg.id]
  ip_address_type    = "ipv4"

  tags = {
    Name = "jonnie-alb"
  }
}

# Add target group registering instance as target & configure health checks
resource "aws_lb_target_group" "target-group" {
  name        = "alb-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.dev_vpc.id

  tags = {
    Name = "alb-target-group"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    matcher             = "200-399"
  }
}

# Attach target group to autoscaling group
resource "aws_autoscaling_attachment" "asg_attachment" {
  alb_target_group_arn    = aws_lb_target_group.target-group.arn
  autoscaling_group_name  = aws_autoscaling_group.private_asg.name
}

# Check for HTTP connection requests using listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}