# Create a VPC to launch our instances into
resource "aws_vpc" "dev_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    terraform = "true"
    Name      = "jonnie-vpc"
  }
}