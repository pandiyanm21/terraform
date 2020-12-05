# MyCloudLMS VPC
resource "aws_vpc" "mycloudlms" {
cidr_block       = "10.0.0.0/16"
instance_tenancy = "default"
enable_dns_support = true
enable_dns_hostnames = true
enable_classiclink = false
tags = {
    Name = "mycloudlms-vpc"
  }
}

# Subnets

resource "aws_subnet" "public-1A" {
vpc_id     = aws_vpc.mycloudlms.id
cidr_block = "10.0.1.0/24"
availability_zone = "eu-west-1a"
map_public_ip_on_launch = true
tags = {
    Name = "public-1A"
  }  
}

resource "aws_subnet" "public-1B" {
vpc_id     = aws_vpc.mycloudlms.id
cidr_block = "10.0.2.0/24"
availability_zone = "eu-west-1b"
map_public_ip_on_launch = true
tags = {
    Name = "public-1B"
  }  
}

resource "aws_subnet" "public-1C" {
vpc_id     = aws_vpc.mycloudlms.id
cidr_block = "10.0.3.0/24"
availability_zone = "eu-west-1c"
map_public_ip_on_launch = true
tags = {
    Name = "public-1C"
  }  
}

resource "aws_subnet" "private-1a" {
vpc_id     = aws_vpc.mycloudlms.id
cidr_block = "10.0.4.0/24"
availability_zone = "eu-west-1a"
map_public_ip_on_launch = false
tags = {
    Name = "private-1a"
  }  
  
}

resource "aws_subnet" "private-1b" {
vpc_id     = aws_vpc.mycloudlms.id
cidr_block = "10.0.5.0/24"
availability_zone = "eu-west-1b"
map_public_ip_on_launch = false

tags = {
    Name = "private-1b"
  }  
}

resource "aws_subnet" "private-1c" {
vpc_id     = aws_vpc.mycloudlms.id
cidr_block = "10.0.6.0/24"
availability_zone = "eu-west-1c"
map_public_ip_on_launch = false
tags = {
    Name = "private-1c"
  }  
}

# Internet gateway

resource "aws_internet_gateway" "mycloudlms-IGW" {
vpc_id = aws_vpc.mycloudlms.id
tags = {
    "Name" = "mycloudlms-IGW"
  }
}

# Route table

resource "aws_route_table" "public-Route" {
vpc_id = aws_vpc.mycloudlms.id
route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.mycloudlms-IGW.id

  # tags = {
  #   Name = "public-Route"
  # }

  } 
}

# Route table association public

resource "aws_route_table_association" "pub-sbnt-ass1" {
  subnet_id = aws_subnet.public-1A.id
  route_table_id = aws_route_table.public-Route.id
}

resource "aws_route_table_association" "pub-sbnt-ass2" {
  subnet_id      = aws_subnet.public-1B.id
  route_table_id = aws_route_table.public-Route.id
}

resource "aws_route_table_association" "pub-sbnt-ass3" {
  subnet_id      = aws_subnet.public-1C.id
  route_table_id = aws_route_table.public-Route.id
}