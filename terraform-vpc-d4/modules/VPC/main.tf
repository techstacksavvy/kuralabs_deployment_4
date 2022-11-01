resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main-d4"
  }
}

# Create Internet Gateway and attach it to VPC

resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
  vpc_id =  aws_vpc.main.id               # vpc_id will be generated after we create VPC
 
 }

# Create a Public Subnets
 
resource "aws_subnet" "publicsubnets" {    # Creating Public Subnets
  vpc_id =  aws_vpc.main.id
  cidr_block = "${var.public_subnets}"        # CIDR block of public subnets

}

# Create a Private Subnet                   
 
resource "aws_subnet" "privatesubnets" {         # Creating Private Subnets
  vpc_id =  aws_vpc.main.id
  cidr_block = "${var.private_subnets}"          # CIDR block of private subnets
 }

# Route table for Public Subnet's

resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
  vpc_id =  aws_vpc.Main.id
         route {
  cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
  gateway_id = aws_internet_gateway.IGW.id
     }
 }
