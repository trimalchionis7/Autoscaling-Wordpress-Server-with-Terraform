# Variables
variable "region" {
  default     = "eu-central-1"
  description = "AWS Region"
}

variable "az" {
  description = "Availability zone to create subnet"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
  default     = ["aws_subnet.public-1.id", "aws_subnet.public-2.id"]
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/20"
}
variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  default     = ["10.0.2.0/24", "10.0.4.0/24"]
}
variable "key_name" {
  description = "Key pair resource for EC2"
  default     = "jonnie-vpc"
}

variable "rds_name" {
  description = "RDS DB name"
  default     = "jonnierds"
}

variable "rds_username" {
  description = "RDS DB username"
  default     = "rds_username"
}

variable "rds_password" {
  description = "RDS DB password"
  default     = "rds_password"
}

variable "rds_rootpassword" {
  description = "RDS DB root password"
  default     = "rds_rootpassword"
}

variable "aws_s3_bucket" {
  description = "S3 bucket name"
  default     = "jonnie-s3"
}
