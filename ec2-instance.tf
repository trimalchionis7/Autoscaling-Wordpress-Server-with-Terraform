# Create specified numbe of EC2 instances

locals {
  # The name of the EC2 instance
  name = "jonnie-ec2"
  owner = "jonnie"
}

# Select the newest AMI
data "aws_ami" "latest_linux_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*x86_64"]
  }
}

resource "aws_instance" "instance" {
  ami                         = data.aws_ami.latest_linux_ami.id
  # ami                       = var.AMIs[var.region]
  instance_type               = "t3.micro"
  availability_zone           = "us-west-2a" # how to create instances across 2 AZs
  associate_public_ip_address = true
  key_name                    = "jonnie-vpc"
  count                       = 2
  subnet_id                   = aws_subnet.public-1.id # how to launch 1 instance in 2 subnets
  # iam_instance_profile      = "LabRole"
  user_data                   = file("mariadb-setup.sh")
  # vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

  root_block_device {
    volume_size = 8
  }
  tags = {
    Name = "jonnie-ec2-instance"
  }
}