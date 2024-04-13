# Create public route table
resource "aws_route_table" "RB_Public_RouteTable" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Associate public route table with public subnets
resource "aws_route_table_association" "Public_Subnet1_Asso" {
  depends_on     = [aws_route_table.RB_Public_RouteTable, aws_subnet.public-1]
  route_table_id = aws_route_table.RB_Public_RouteTable.id
  subnet_id      = aws_subnet.public-1.id
}

resource "aws_route_table_association" "Public_Subnet2_Asso" {
  depends_on     = [aws_route_table.RB_Public_RouteTable, aws_subnet.public-2]
  route_table_id = aws_route_table.RB_Public_RouteTable.id
  subnet_id      = aws_subnet.public-2.id
}