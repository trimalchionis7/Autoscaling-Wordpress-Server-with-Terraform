# variables.tf

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
    description = "CIDR blocks for the public subnets"
    default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidr_blocks" {
    description = "CIDR blocks for the private subnets"
    default = ["10.0.2.0/24", "10.0.4.0/24"]
}
variable "AWS_REGION" {
    default = "us-west-2"
    description = "AWS Region"
}
variable "AMIs" {
    type = map(string)
    description = "Region specific AMI"
    default = {
    us-east-1 = "ami-0230bd60aa48260c6"
    eu-central-1 = "ami-0ec8c354f85e48227"
    }
}