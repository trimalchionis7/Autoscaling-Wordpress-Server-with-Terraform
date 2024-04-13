# Create bastion host in public subnet 1

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.latest_linux_ami.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.public-1.id
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  tags = {
    Name = "Bastion Host"
  }
}