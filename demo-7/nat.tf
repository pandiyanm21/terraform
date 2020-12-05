#ng
resource "aws_eip" "nat-ip" {
    vpc = true
  
}

# NAT gateway

resource "aws_nat_gateway" "mycloudlms-NGW" {
    allocation_id = aws_eip.nat-ip.id
    subnet_id     = aws_subnet.public-1A.id

  tags = {
    Name = "mycloudlms-NGW"
  }
}

# Route to NAT gateway

resource "aws_route_table" "pri-route" {
vpc_id = aws_vpc.mycloudlms.id
route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.mycloudlms-NGW.id

}  
}

# Route association to route gateway

resource "aws_route_table_association" "pri-route-1" {
    subnet_id = aws_subnet.private-1a.id
    route_table_id = aws_route_table.pri-route.id
}

resource "aws_route_table_association" "pri-route-2" {
    subnet_id = aws_subnet.private-1b.id
    route_table_id = aws_route_table.pri-route.id
}

resource "aws_route_table_association" "pri-route-3" {
    subnet_id = aws_subnet.private-1c.id
    route_table_id = aws_route_table.pri-route.id
}


