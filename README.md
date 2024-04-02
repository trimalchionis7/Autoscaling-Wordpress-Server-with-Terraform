# Launching an AWS VPC with Wordpress web server using Terraform

This project contains all the files you'll need to launch a VPC (Virtual Private Cloud) with Amazon Web Services containing a pre-configured Wordpress web server and launched using Terraform.

I completed it as part of a 12-week full-time bootcamp in AWS Cloud Computing which I took part in during the spring of 2024. It's the first project which I've attempted using AWS Services and was also my first experience with Terraform. Enjoy!

***

## Prerequisites

Before getting started, ensure you have the following installed and configured:

- Terraform in your CLI
- AWS account with appropriate permissions
- AWS CLI configured with access key & secret key

## Background and Motivation

**Amazon Web Services (AWS)** is a popular cloud computing platform with a huge range of services in areas such as computing, storage. networking, databases, analytics, machine learning and more. AWS enables businesses to build and deploy applications quickly and securely at scale while reducing infrastructure costs.

A **Virtual Private Cloud (VPC)** is a logically isolated section of the AWS cloud where you can launch AWS resources in a customised virtual network. In a VPC you define your own IP address range, configure route tables, subnets, and network gateways, and you manage your own security settings using security groups and network access control lists (ACLs). VPCs provide a secure and scalable environment for deploying AWS resources while ensuring isolation from other networks.

**Terraform** is a popular and open-source **Infrastructure as Code (IaC)** tool developed by Hashicorp. It allows users to define and provision infrastructure resources using declarative configuration files. With Terraform, you specify the resources you need (such as virtual machines, networks, storage, etc.) and manage their lifecycle from creation to destruction. Terraform automates the provisioning process, improves infrastructure consistency and enables version-controlled infrastructure changes.

**Wordpress** is a popular open-source content management system (CMS) used for creating websites, blogs, and online stores. It is built on PHP and MySQL and offers a user-friendly interface for managing website content, themes and plugins. A Wordpress server typically consists of a web-server software (e.g. Apache or Nginx) running PHP to serve Wordpress files, a MySQL or MariaDB database to store website data, and additional components for caching, security and better performance.

## Project Structure and Configuration

Here is a diagram of my VPC configuration (generated with draw.io):

![VPC Configuration Diagram](/pictures/vpc-diagram.jpg)

The configuration includes the following components:
- **VPC**: a logically isolated virtual network in the AWS Region us-west-2 with CIDR block 10.0.0.0/16.

- **Availability Zones**: 2 Availability Zones set to us-west-2a and us-west-2b. Using multiple AZs ensures redundancy and fault tolerance, so that, if one AZ experiences an outage or failure, resources in the other AZs remain unaffected.

- **2 public and 2 private subnets per AZ**: Each subnet has its own unique CIDR block to prevent IP address conflicts. Using the length of prefix /24 allows for 2^8 (256) IP addresses, with 254 usable addresses for hosts (since the first address is reserved as the network address and the last address is reserved as the broadcast address).

- **Internet Gateway**: allows internet association in the public subnet. When associating your subnets with the internet, it is necessary to add destination '0.0.0.0/0' (representing all internet-bound traffic) as a route in your route table and to set the target to the Internet Gateway ID.

- **Application Load Balancer**: An ALB distributes incoming traffic across multiple targets, in this case EC2 instances. This ensures that the instances are highly available, fault tolerant and scalable (when configured in combination with the Autoscaling group).

- **Autoscaling group**: Autoscaling ensures balanced compute power by automatically adjusting the number of EC2 instances in response to changes in demand or resource utilisation. I have set the minimum, maximum and desired capacity and configured a target tracking scaling policy of average 60% CPU utilisation.

- **EC2 instances**: All EC2 instances are preconfigured with Apache web server, a popular software which provides web content over HTTP, and the Wordpress content management system. This applies both to the 2 EC2 instances that are initially created and to the launch template which is used for the instances that are created via autoscaling.

- **RDS database**: The Amazon RDS (Relational Database Service) is used as a managed relational database and backend to the Wordpress application. It stores all the website's data, including posts, pages, comments, user information and settings. The RDS is placed in the private subnet (where there is no internet connectivity) for greater security and protection from external threats. Also, since this is a multi-AZ deployment, Amazon RDS automatically creates a primary database instance and synchronously replicates the data to an instance in a different AZ, so that, in case of failure, failover to the standby instance can occur without manual intervention.

- **S3 bucket**: I have included a configuration file for an S3 bucket as a web storage solution. For instance, the user may wish to copy or synchronise the Wordpress installation files from the EC2 instance to the S3 bucket. For this, it is necessary to either configure AWS manually on the instance or preconfigure AWS in the instance by assigning to it an IAM role.

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