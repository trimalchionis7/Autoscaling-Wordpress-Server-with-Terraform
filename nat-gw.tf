/*

# Create NAT gateway in public subnet 1
resource "aws_nat_gateway" "nat-gw" {
  count         = 1
  allocation_id = element(aws_eip.nat-eip.*.id, count.index)
  subnet_id     = aws_subnet.public-1.id

  tags = {
    Name = "nat-gw"
  }
}

# Create Elastic IP for NAT gateway
resource "aws_eip" "nat-eip" {
  vpc = true

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_route_table" "RB_Private_RouteTable" {
  vpc_id = aws_vpc.dev_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat-gw[0].id
  }
}

*/