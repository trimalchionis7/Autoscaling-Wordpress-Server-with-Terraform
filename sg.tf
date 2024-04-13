# Create security group for bastion host
resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Allows SSH access from anywhere"
  vpc_id      = aws_vpc.dev_vpc.id

  # Add inbound rules
  # Allow SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add an inbound rule
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add an outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

# Create security group which traffics internet to the ALB
resource "aws_security_group" "alb-sg" {
  name        = "load_balancer_security_group"
  description = "Controls internet access to the ALB"
  vpc_id      = aws_vpc.dev_vpc.id

  # Add inbound rules
  # Allow HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add an outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

# Create security group which traffics HTTP from ALB & SSH from bastion host
resource "aws_security_group" "asg_security_group" {
  name        = "asg-security-group"
  description = "Allows internet connectivity for EC2 instances"
  vpc_id      = aws_vpc.dev_vpc.id

  # Add inbound rules
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  # Allow SSH access only from bastion host

  ingress {
    description     = "SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion-sg.id]
  }

  # Add an outbound rule
  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  tags = {
    Name = "asg-sg"
  }
}

# Create security group for RDS database
resource "aws_security_group" "allow_ec2_rds" {
  name        = "allow_ec2_rds"
  description = "Allow RDS inbound traffic from ec2"
  vpc_id      = aws_vpc.dev_vpc.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}