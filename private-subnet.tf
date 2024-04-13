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