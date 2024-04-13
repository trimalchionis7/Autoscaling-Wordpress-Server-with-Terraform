# Create specified number of EC2 instances

locals {
  # The name of the EC2 instance
  name  = "jonnie-ec2"
  owner = "jonnie"
}

# Select the newest Amazon Linux 2 AMI
data "aws_ami" "latest_linux_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}
resource "aws_instance" "instance-1" {
  ami                         = data.aws_ami.latest_linux_ami.id
  instance_type               = "t3.micro"
  availability_zone           = var.az[0]
  # associate_public_ip_address = true
  key_name                    = var.key_name
  count                       = 1
  vpc_security_group_ids      = [aws_security_group.asg_security_group.id]
  subnet_id                   = aws_subnet.private-1.id
  # user_data                   = base64encode(data.template_file.user-data.rendered)
  tags = {
    Name = "instance-1"
  }
}

resource "aws_instance" "instance-2" {
  ami                         = data.aws_ami.latest_linux_ami.id
  instance_type               = "t3.micro"
  availability_zone           = var.az[1]
  # associate_public_ip_address = true
  key_name                    = var.key_name
  count                       = 1
  vpc_security_group_ids      = [aws_security_group.asg_security_group.id]
  subnet_id                   = aws_subnet.private-2.id
  # user_data                   = base64encode(data.template_file.user-data.rendered)
  tags = {
    Name = "instance-2"
  }
}

# Render template file
/* data "template_file" "user-data" {
  template = file("wordpress-init.tpl")

  vars = {
    rds_name         = "${var.rds_name}"
    rds_username     = "${var.rds_username}"
    rds_password     = "${var.rds_password}"
    rds_rootpassword = "${var.rds_rootpassword}"
    rds_endpoint     = replace("${data.aws_db_instance.jonnie-rds.endpoint}", ":3306", "")
  }
} */