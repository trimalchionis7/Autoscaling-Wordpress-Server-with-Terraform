# Code for running EC2 instance in Terraform

resource "aws_instance" "instance" {
  ami = "ami-0d442a425e2e0a743"
  instance_type               = "t3.micro"
  availability_zone           = "us-west-2a"
  associate_public_ip_address = true
  key_name                    = "vockey"
  vpc_security_group_ids      = ["sg-0dbed35222cb4e2f7"]
  subnet_id                   = "subnet-079808b6cfcaad7a4"
  # iam_instance_profile      = "LabRole"
  count = 1
  tags = {
    Name = "first-try"
  }
}