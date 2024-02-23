# Create a Security Group for the VPC
resource "aws_security_group" "sg_vpc" {
  name        = "sg_vpc"
  description = "allow shh"
  vpc_id      = aws_vpc.dev_vpc.id
}

# Add inbound rules
# Add a rule for HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Add a rule for SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description      = "allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }