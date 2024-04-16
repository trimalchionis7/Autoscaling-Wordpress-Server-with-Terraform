# Securely Auto-Scaling a Wordpress Web Server in a Multi-AZ AWS VPC using Terraform

In this project, I launch a Multi-AZ AWS VPC with two-tier architecture using the IaC tool Terraform. I completed it as a capstone project for a 12-week online bootcamp in AWS Cloud Computing in the spring of 2024. In this README, I walk you through the steps needed to execute this project in your own machine. Thanks for your interest and enjoy!

***

## Prerequisites

Before getting started, ensure you have the following installed and configured:

- Terraform in your CLI
- AWS account with appropriate permissions
- AWS CLI configured with access key & secret key

## Background and Motivation

**Amazon Web Services (AWS)** is a popular cloud computing platform with a huge range of services in areas such as computing, storage, networking, databases, analytics, machine learning and more. AWS enables businesses to build and deploy applications quickly and securely at scale while reducing infrastructure costs.

A **Virtual Private Cloud (VPC)** is a logically isolated section of the AWS cloud where you can launch AWS resources in a customised virtual network. In a VPC you define your own IP address range, configure route tables, subnets, and network gateways, and you manage your own security settings using security groups and network access control lists (ACLs). VPCs provide a secure and scalable environment for deploying AWS resources while ensuring isolation from other networks.

**Terraform** is a popular and open-source **Infrastructure as Code (IaC)** tool developed by Hashicorp. It allows users to define and provision infrastructure resources using declarative configuration files. With Terraform, you specify the resources you need (such as virtual machines, networks, storage, etc.) and manage their lifecycle from creation to destruction. Terraform automates the provisioning process, improves infrastructure consistency and enables version-controlled infrastructure changes.

**Wordpress** is a popular open-source content management system (CMS) used for creating websites, blogs, and online stores. It is built on PHP and MySQL and offers a user-friendly interface for managing website content, themes and plugins. A Wordpress server typically consists of a web-server software (e.g. Apache or Nginx) running PHP to serve Wordpress files, a MySQL or MariaDB database to store website data, and additional components for caching, security and better performance.

## Project Structure and Configuration

Here is a diagram of my VPC configuration (generated with draw.io):

![VPC Configuration Diagram](/pictures/vpc-diagram.png)

The configuration includes the following components:
- **VPC**: a logically isolated virtual network in the AWS Region eu-central-1 with CIDR block 10.0.0.0/16.

- **Availability Zones**: 2 Availability Zones set to eu-central-1a and eu-central-1b. Using multiple AZs ensures redundancy and fault tolerance, so that, if one AZ experiences an outage or failure, resources in the other AZs remain unaffected.

- **2 public and 2 private subnets per AZ**: Each subnet has its own unique CIDR block to prevent IP address conflicts. Using the length of prefix /24 allows for 2^8 (256) IP addresses, with 254 usable addresses for hosts (since the first address is reserved as the network address and the last address is reserved as the broadcast address).

- **Internet Gateway**: Allows internet connectivity in the public subnet. When connecting your subnets with the internet, it is necessary to add destination '0.0.0.0/0' (representing all internet-bound traffic) as a route in your route table and to set the target to the Internet Gateway ID.

- **Bastion host**: The bastion host or jumpbox is a single EC2 instance connected to the internet which provides a secure point of entry for accessing the EC2 instances in the private subnets. Only authorized users can gain access to the private network, as SSH is restricted to entry through the bastion host alone. This provides the web servers with greater protection from attack if they are hosting private or confidential data.

- **NAT Gateway**: Hosted in the public subnet and enables internet connectivity for the EC2 instances in the private subnet. Note that AWS charges for each hour that the NAT Gateway is available and each gigabyte of data processed.

- **Application Load Balancer**: An ALB distributes incoming traffic across multiple targets, in this case EC2 instances. This ensures that the instances are highly available, fault tolerant and scalable (when configured in combination with the Autoscaling group).

- **Autoscaling group**: Autoscaling ensures balanced compute power by automatically adjusting the number of EC2 instances in response to changes in demand or resource utilisation. I have set the minimum, maximum and desired capacity and configured a target tracking scaling policy of average 60% CPU utilisation.

- **EC2 instances**: All EC2 instances are preconfigured with Apache web server, a popular software which provides web content over HTTP, and the Wordpress content management system. This applies both to the 2 EC2 instances that are initially created and to the launch template which is used for the instances that are created via autoscaling.

- **RDS database**: Amazon RDS (Relational Database Service) is a managed relational database service and backend to the Wordpress application. It stores all the website's data, including posts, pages, comments, user information and settings. The RDS is placed in the private subnet for greater security and protection from external threats. Also, since this is a multi-AZ deployment, Amazon RDS automatically creates a primary database instance and synchronously replicates the data to an instance in a different AZ, so that, in case of failure, failover to the standby instance can occur without manual intervention.

- **S3 bucket**: I have included a configuration file for a S3 bucket as a web storage solution. For instance, the user may wish to copy or synchronise the Wordpress installation files from the EC2 instance to the S3 bucket. For this, it is necessary to either configure AWS manually on the instance or preconfigure AWS in the instance by assigning to it an IAM role.

# Setting up your Environment

Before proceeding with the deployment, you need to take 2 steps to set up your personal environment.

1. Create a key pair for your EC2 instances and set the key pair name as the default value in the variable block "key_name" within the variables.tf file.

A key pair is a set of cryptographic keys which allows secure access to EC2 instances. It consists of both a public key, which is stored on the EC2 instance, and a private key, which is stored on your own machine. You can create a key pair using either the AWS Management Console or the CLI, following the instructions provided [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws).

2. Provide a unique name for the S3 bucket by setting a default value in the variable block "aws_s3_bucket" within the variables.tf file.

# Steps to Deployment

After cloning this repository into a suitable working directory on your machine, you can deploy this infrastructure using the following CLI commands:

- terraform init
(initialises Terraform in the working directory and downloads necessary plugins/configuration)

- terraform validate
(Checks the TF files for syntax errors and checks against the defined provider)

- terraform plan
(Generates an execution plan based on the current state of the infrastructure and Terraform configuration)

- terraform apply
(Applies the execution plan generated by 'terraform plan')

After deployment is complete:

- terraform destroy
(Destroys all the resources defined in the configuration)

# Final words

Thanks for reading this documentation and enjoy developing with Terraform and AWS! 🎯
