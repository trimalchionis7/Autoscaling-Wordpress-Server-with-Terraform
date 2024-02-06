# Code for running EC2 instance in Terraform

resource "aws_instance" "instance" {
  ami = "ami-0d442a425e2e0a743"
  instance_type               = "t3.micro"
  availability_zone           = "us-west-2a"
  associate_public_ip_address = true
  key_name                    = "vockey"
  vpc_security_group_ids      = ["sg-0087df50e06ac8e41"]
  subnet_id                   = "subnet-03ded5ebd78ed0d37"
  # iam_instance_profile        = "<lab role>"
  count = 1
  tags = {
    Name = "first-try"
  }
}