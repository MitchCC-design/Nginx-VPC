Terraform AWS VPC and EC2 Deployment

This repository contains a complete Terraform configuration that provisions the following infrastructure components on AWS:

Summary

This configuration will:
	•	Create a Virtual Private Cloud (VPC) with a CIDR block of 10.0.0.0/16
	•	Provision a public subnet within the VPC using CIDR 10.0.0.0/24
	•	Deploy an Internet Gateway and attach it to the VPC
	•	Create a route table with a route to the Internet Gateway and associate it with the subnet
	•	Launch an EC2 instance within the public subnet
	•	Attach a security group that allows inbound HTTP (80) and HTTPS (443) traffic

Components
	•	VPC
Defines the network boundary. CIDR block: 10.0.0.0/16.
	•	Subnet
A public subnet carved out from the VPC. CIDR block: 10.0.0.0/24.
	•	Internet Gateway
Enables access to and from the internet for public subnets.
	•	Route Table and Association
Routes all outbound traffic (0.0.0.0/0) from the subnet to the Internet Gateway.
	•	EC2 Instance
Launched with:
	•	AMI ID: ami-0ee3a8bd34ec25f25
	•	Instance type: t2.micro
	•	10 GB gp2 root volume
	•	Public IP associated
	•	Security Group
Allows:
	•	TCP port 80 (HTTP) from anywhere
	•	TCP port 443 (HTTPS) from anywhere

Prerequisites
	•	Terraform >= 1.7.0
	•	AWS credentials configured via environment variables or shared credentials file
	•	An AWS account with permissions to create VPC, subnets, EC2 instances, and security groups

Destruction

To tear down all resources:

terraform destroy

Notes
	•	Make sure the AMI ID is valid in the region you’re deploying to.
	•	Update region or availability zone in the provider and aws_subnet blocks if needed.
	•	Tags are managed centrally using the locals block to ensure consistency across resources.
