# Create a VPC to launch our instances into
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"  
  enable_dns_hostnames = true 
  enable_dns_support = true
  
  tags       =  {
    name     = "deham10"
  }       
}

# Create 2 public & 2 private subnets in 2 different AZ
resource "aws_subnet" "public-1" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "deham10"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id     = aws_vpc.dev_vpc.id 
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "deham10" 
  }
}

resource "aws_subnet" "public-2" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "deham10"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id     = aws_vpc.dev_vpc.id 
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "deham10" 
  }
}