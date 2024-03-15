This repository contains the code for launching an EC2 instance in a custom-made VPC using Terraform.

The EC2 instance has Apache web server, httpd and Wordpress pre-installed.

The VPC contains 2 availability zones with 1 public and 1 private subnet in each AZ. Internet association is made through an internet gateway in the public subnet and through a NAT gateway associated to an elastic IP address in the private subnet. Autoscaling and Application Load Balancer are also included.

The following installations are needed for deployment:
- Terraform (latest version)
- AWS CLI
