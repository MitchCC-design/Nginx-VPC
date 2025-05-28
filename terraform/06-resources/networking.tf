# Allows you to store information to avoid code duplication 
# Now you can use the common_tags variable in multiple resources by referencing it.
locals {
  common_tags = {
    Managed_by = "terraform"
    project    = "06-resources"
  }
}

# Resource block for creating a VPC in AWS using Terraform
resource "aws_vpc" "main" { #
  cidr_block = "10.0.0.0/16"
  # tags are used to organize and manage resources in AWS
  tags = merge(local.common_tags, {
    name = "06-resources"
  })
  # Before we had to define the tags like this for each resource,
  # Name       = "06-resources-vpc"
  # Managed_by = "terraform"
  # project    = "06-resources"

}
# Resource block for creating a public subnet in the VPC
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id # Reference the VPC created above
  cidr_block        = "10.0.0.0/24"   # Carves out a portion of the VPC's IP address range for the subnet, this is needed to avoid conflicts with other subnets or resources.
  availability_zone = "us-west-2a"    # Specify the availability zone for the subnet
  tags = merge(local.common_tags, {
    name = "06-resources-public"
  })
}
# Internet Gateway connects the VPC to the internet, allowing resources in the VPC to communicate with the internet.
# This is necessary for resources that need to be publicly accessible.
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id # Attach the internet gateway to the VPC
  tags   = local.common_tags
}

# Resource block for creating a route table for the public subnet, which defines how traffic is routed within the VPC. Needed to allow resources in the public subnet to access the internet.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id # Reference the VPC created above
  route {
    cidr_block = "0.0.0.0/0"                  # This route allows all outbound traffic to the internet
    gateway_id = aws_internet_gateway.main.id # Use the internet gateway created above to route traffic to the internet
  }
  tags = local.common_tags
}
# This resource block associates the public subnet with the route table, allowing the subnet to use the routes defined in the route table.
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id      # Associate the public subnet with the route table
  route_table_id = aws_route_table.public.id # Use the route table created above
}
