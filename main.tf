provider "aws" {
  region = "ap-south-1"
}

#creating vpc name,cidr and tags
resource "aws_vpc" "shikha" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
   tags = {
    Name = "shikha"
  }
}

#creating public subnets in vpc

resource "aws_subnet" "shikha-public-1" {
  vpc_id     = aws_vpc.shikha.id
  cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = "true"
availability_zone = "ap-south-1a"
  tags = {
    Name = "shikha-public-1"
  }
}

resource "aws_subnet" "shikha-public-2" {
  vpc_id     = aws_vpc.shikha.id
  cidr_block = "10.0.0.0/24"
map_public_ip_on_launch = "true"
availability_zone = "ap-south-1b"
  tags = {
    Name = "shikha-public-2"
  }
}
#creating internet gateway in aws vpc
resource "aws_internet_gateway" "shikha-gw" {
  vpc_id = aws_vpc.shikha.id

  tags = {
    Name = "shikha-gw"
  }
}
#creating routetble for internetgateway
resource "aws_route_table" "shikha-public" {
  vpc_id = aws_vpc.shikha.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shikha-gw.id
  }

  tags = {
    Name = "shikha-public"
  }
}
#creating route association public subnets
resource "aws_route_table_association" "shikha-public-1" {
  subnet_id      = aws_subnet.shikha-public-1.id
  route_table_id = aws_route_table.shikha-public.id
}
resource "aws_route_table_association" "shikha-public-2" {
  gateway_id     = aws_internet_gateway.shikha-gw.id
  route_table_id = aws_route_table.shikha-public.id
}
#creating ec2 instance in public subnet

resource "aws_instance" "public-inst-1" {
  subnet_id     = "${aws_subnet.shikha-public-1.id}"
  ami           = "ami-0a5ac53f63249fba0"
  instance_type = "t2.micro"

tags = {
  Name = "public-inst-1"
}
}

resource "aws_instance" "public-inst-2" {
  subnet_id     = "${aws_subnet.shikha-public-2.id}"
  ami           = "ami-0a5ac53f63249fba0"
  instance_type = "t2.micro"

tags = {
  Name = "public-inst-2"
}
}