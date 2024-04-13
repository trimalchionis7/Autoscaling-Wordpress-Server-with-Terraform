# Create two private subnets in different AZs
resource "aws_subnet" "private-1" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[0]
  availability_zone = var.az[0]

  tags = {
    Name = "private-1"
  }
}
resource "aws_subnet" "private-2" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[1]
  availability_zone = var.az[1]

  tags = {
    Name = "private-2"
  }
}

# Create private route table
resource "aws_route_table" "RB_Private_RouteTable" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "private-rt"
  }
}

# Associate private route table with subnet
resource "aws_route_table_association" "Private_Subnet1_Asso" {
  depends_on     = [aws_route_table.RB_Private_RouteTable, aws_subnet.private-1]
  route_table_id = aws_route_table.RB_Private_RouteTable.id
  subnet_id      = aws_subnet.private-1.id
}
resource "aws_route_table_association" "Private_Subnet2_Asso" {
  depends_on     = [aws_route_table.RB_Private_RouteTable, aws_subnet.private-2]
  route_table_id = aws_route_table.RB_Private_RouteTable.id
  subnet_id      = aws_subnet.private-2.id
}

# Create 2 private subnets in different AZs
resource "aws_subnet" "private-1" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[0]
  availability_zone = var.az[0]

  tags = {
    Name = "private-1"
  }
}
resource "aws_subnet" "private-2" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[1]
  availability_zone = var.az[1]

  tags = {
    Name = "private-2"
  }
}