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