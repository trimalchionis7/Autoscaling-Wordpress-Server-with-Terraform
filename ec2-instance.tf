# Code for launching EC2 instance in Terraform

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
  availability_zone           = "us-west-2a"
  associate_public_ip_address = true
  key_name                    = "jonnie-vpc"
  vpc_security_group_ids      = [aws_security_group.sg_vpc.id]
  subnet_id                   = aws_subnet.public-1.id
  # iam_instance_profile      = "LabRole"
  count = 1
  
  user_data = file("mariadb-setup.sh")
  tags = {
    Name = "jonnie-vpc"
  }
}