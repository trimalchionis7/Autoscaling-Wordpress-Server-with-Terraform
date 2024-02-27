# Create a VPC to launch our instances into
resource "aws_vpc" "dev_vpc" {
  cidr_block          = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "jonnie-vpc"
  }
}

# Define two public subnets in different AZs
resource "aws_subnet" "public-1" {
  vpc_id              = aws_vpc.dev_vpc.id
  cidr_block          = var.public_subnet_cidr_blocks[0]
  availability_zone   = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-1"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id              = aws_vpc.dev_vpc.id
  cidr_block          = var.public_subnet_cidr_blocks[1]
  availability_zone   = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-2"
  }
}

# Define two private subnets in different AZs
resource "aws_subnet" "private-1" {
  vpc_id              = aws_vpc.dev_vpc.id
  cidr_block          = var.private_subnet_cidr_blocks[0]
  availability_zone   = "us-west-2a"

  tags = {
    Name = "private-1"
  }
}
resource "aws_subnet" "private-2" {
  vpc_id              = aws_vpc.dev_vpc.id
  cidr_block          = var.private_subnet_cidr_blocks[1]
  availability_zone   = "us-west-2b"

  tags = {
    Name = "private-2"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "igw_jonnie-vpc"
  }
}

# Create public & private route tables
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

resource "aws_route_table" "RB_Private_RouteTable" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "private-rt"
  }
}

# Associate public & private route tables with subnets
resource "aws_route_table_association" "Public_Subnet1_Asso" {
  route_table_id = aws_route_table.RB_Public_RouteTable.id
  subnet_id      = aws_subnet.public-1.id
  depends_on     = [aws_route_table.RB_Public_RouteTable, aws_subnet.public-1]
}

resource "aws_route_table_association" "Private_Subnet1_Asso" {
  route_table_id = aws_route_table.RB_Private_RouteTable.id
  subnet_id      = aws_subnet.private-1.id
  depends_on     = [aws_route_table.RB_Private_RouteTable, aws_subnet.private-1]
}

resource "aws_route_table_association" "Public_Subnet2_Asso" {
  route_table_id = aws_route_table.RB_Public_RouteTable.id
  subnet_id      = aws_subnet.public-2.id
  depends_on     = [aws_route_table.RB_Public_RouteTable, aws_subnet.public-2]
}

resource "aws_route_table_association" "Private_Subnet2_Asso" {
  route_table_id = aws_route_table.RB_Private_RouteTable.id
  subnet_id      = aws_subnet.private-2.id
  depends_on     = [aws_route_table.RB_Private_RouteTable, aws_subnet.private-2]
}
