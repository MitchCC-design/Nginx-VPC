# Terraform AWS VPC and NGINX EC2 Deployment

This repository provisions an AWS Virtual Private Cloud (VPC) with a public subnet, an internet gateway, and a route table. It deploys a public-facing EC2 instance running NGINX with appropriate security group rules to allow HTTP and HTTPS access.

## Project Objectives

- Deploy a custom VPC with CIDR block `10.0.0.0/16`
- Create a public subnet within the VPC (`10.0.0.0/24`)
- Attach an Internet Gateway to enable outbound access
- Configure a route table to direct traffic to the Internet Gateway
- Launch a t2.micro EC2 instance with public IP and an NGINX image
- Secure the EC2 instance with ingress rules for HTTP (80) and HTTPS (443)

## Architecture Overview

- **Region:** `us-west-2`
- **VPC:** 10.0.0.0/16
- **Public Subnet:** 10.0.0.0/24 (AZ: `us-west-2a`)
- **Internet Gateway:** Attached to VPC
- **Route Table:** Routes `0.0.0.0/0` through IGW
- **EC2 Instance:** Publicly accessible via HTTP/HTTPS
- **Security Group:** Allows ingress on ports 80 and 443 from all IPv4 addresses

## File Structure

```
.
├── main.tf                  # VPC, subnet, IGW, route table, and associations
├── compute.tf               # EC2 instance and security group resources
├── variables.tf             # Input variables (if used)
├── outputs.tf               # Outputs for EC2 public IP, etc. (optional)
└── README.md                # Project documentation
```

## Requirements

- Terraform CLI ≥ 1.7.0
- AWS CLI configured
- IAM user with permissions to manage VPC, EC2, and networking resources

## Usage

```bash
# Clone the repository
git clone git@github.com:MitchCC-design/Nginx-VPC.git
cd Nginx-VPC

# Initialize Terraform and install providers
terraform init

# Review the execution plan
terraform plan

# Deploy the infrastructure
terraform apply

# Destroy the infrastructure
terraform destroy
```

## Key Resources

- `aws_vpc`: Creates a custom VPC
- `aws_subnet`: Carves out a subnet from the VPC
- `aws_internet_gateway`: Enables internet connectivity
- `aws_route_table` and `aws_route_table_association`: Handles routing to the IGW
- `aws_instance`: Provisions a Linux EC2 instance with NGINX
- `aws_security_group` and `aws_vpc_security_group_ingress_rule`: Controls inbound access

## Notes

- The AMI ID must be updated to one compatible with your AWS region if changed.
- NGINX should either be installed via AMI or through user data scripting.
- The security group allows unrestricted inbound access on ports 80 and 443. In production environments, limit ingress IP ranges to trusted sources.

## License

This project is licensed under the MIT License.
