# Code for running EC2 instance in Terraform

resource "aws_instance" "instance" {
  ami = "ami-0d442a425e2e0a743"
  instance_type               = "t3.micro"
  availability_zone           = "us-west-2a"
  associate_public_ip_address = true
  key_name                    = "vockey"
  vpc_security_group_ids      = ["sg-06c6b023048ee9ad9"]
  subnet_id                   = "subnet-07b832ebd68ea0cda"
  # iam_instance_profile      = "LabRole"
  count = 1
  tags = {
    Name = "first-try"
  }
}