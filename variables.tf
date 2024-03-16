# Variables

variable "region" {
    default = "us-west-2"
    description = "AWS Region"
}

variable "az" {
  description = "Availability zone to create subnet"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"] 
}

variable "subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
  default     = ["aws_subnet.public-1.id", "aws_subnet.public-2.id"]
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  default     = ["10.0.2.0/24", "10.0.4.0/24"]
}

/*variable "latest_amazon_linux_ami" {
  description = "Latest Amazon Linux AMI for the specified region"
  type        = string
  default     = "ami-0895022f3dac85884"
}

variable "AMIs" {
    type = map(string)
    description = "Region specific AMI"
    default = {
    us-west-2 = "ami-0895022f3dac85884"
    }
}*/
