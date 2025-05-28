resource "aws_instance" "web" {
  ami                         = "ami-0ee3a8bd34ec25f25"               # Replace with a valid AMI ID for your region
  associate_public_ip_address = true                                  # Associate a public IP address
  instance_type               = "t2.micro"                            # Specify the instance type
  subnet_id                   = aws_subnet.public.id                  # Reference the public subnet created in networking.tf
  vpc_security_group_ids      = [aws_security_group.Publictraffic.id] # Attach the security group created below
  # A root block device is the primary storage device for the instance, typically containing the OS.
  root_block_device {
    delete_on_termination = true  # Ensure the root block device is   deleted when the instance is terminated
    volume_size           = 10    # Specify the size of the root block device in GB
    volume_type           = "gp2" # Specify the volume type (General Purpose SSD)
  }
}

# Security group to allow HTTP traffic to the web instance
resource "aws_security_group" "Publictraffic" {
  name        = "PublicTraffic"
  description = "Allow public traffic to the web instance"
  vpc_id      = aws_vpc.main.id # Reference the VPC created in networking.tf

}
# Security group rule to allow HTTP traffic on port 80 from anywhere
resource "aws_vpc_security_group_ingress_rule" "web_http" {
  security_group_id = aws_security_group.Publictraffic.id # Reference the security group created above
  ip_protocol       = "tcp"                                     # Allow TCP traffic
  from_port         = 80                                        # Allow HTTP traffic on port 80
  to_port           = 80                                        # Allow HTTP traffic on port 80
  cidr_ipv4         = "0.0.0.0/0"                               # Allow from anywhere
}
# Security group rule to allow HTTPS traffic on port 443 from anywhere
resource "aws_vpc_security_group_ingress_rule" "web_https" {
  security_group_id = aws_security_group.Publictraffic.id # Reference the security group created above
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}