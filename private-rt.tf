# Create private route table
resource "aws_route_table" "RB_Private_RouteTable" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-gw.id
    
  }
  tags = {
    Name = "private-rt"
  }
}

# Associate private route table with private subnets
resource "aws_route_table_association" "Private_Subnet1_Asso" {
  depends_on     = [aws_nat_gateway.nat-gw]
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.RB_Private_RouteTable.id
  
}
resource "aws_route_table_association" "Private_Subnet2_Asso" {
  depends_on     = [aws_nat_gateway.nat-gw]
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.RB_Private_RouteTable.id
}