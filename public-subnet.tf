# Create two public subnets in different AZs
resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[0]
  availability_zone       = var.az[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-1"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[1]
  availability_zone       = var.az[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-2"
  }
}

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

# Associate public route table with subnets
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