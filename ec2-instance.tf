# Create specified number of EC2 instances

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

resource "aws_instance" "instance-1" {
  ami                         = data.aws_ami.latest_linux_ami.id
  # ami                       = var.AMIs[var.region]
  instance_type               = "t3.micro"
  availability_zone           = var.az[0]
  associate_public_ip_address = true
  key_name                    = "jonnie-vpc"
  count                       = 1
  subnet_id                   = aws_subnet.public-1.id
  # iam_instance_profile      = "LabRole"
  user_data                   = file("mariadb-setup.sh")
  tags = {
    Name = "instance-1"
  }
}

resource "aws_instance" "instance-2" {
  ami                         = data.aws_ami.latest_linux_ami.id
  # ami                       = var.AMIs[var.region]
  instance_type               = "t3.micro"
  availability_zone           = var.az[1]
  associate_public_ip_address = true
  key_name                    = "jonnie-vpc"
  count                       = 1
  subnet_id                   = aws_subnet.public-2.id
  # iam_instance_profile      = "LabRole"
  user_data                   = file("mariadb-setup.sh")

  tags = {
    Name = "instance-2"
  }
}