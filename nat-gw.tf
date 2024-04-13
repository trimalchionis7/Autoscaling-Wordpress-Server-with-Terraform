# Create Elastic IP for NAT gateway

resource "aws_eip" "nat-eip" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.5"
  depends_on                = [aws_internet_gateway.igw]

  tags = {
    Name = "nat-eip"
  }
}

# Create NAT gateway in public subnet

resource "aws_nat_gateway" "nat-gw" {
  allocation_id     = aws_eip.nat-eip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public-1.id

  tags = {
    Name = "nat-gw"
  }

  depends_on = [aws_internet_gateway.igw]
}