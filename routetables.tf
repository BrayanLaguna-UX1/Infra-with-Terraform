resource "aws_route_table" "PubRT" {
    vpc_id = aws_vpc.myvpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myitg.id
    }
    

    tags = {
        Name = "publicroutetable"
    }
  
}

resource "aws_route_table" "PrivRT" {
    vpc_id = aws_vpc.myvpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.mynat.id
    }

    tags = {
      Name = "Privroutetable"
    }
  
}

resource "aws_route_table_association" "pubAssRT" {
    subnet_id = aws_subnet.subnetpub.id
    route_table_id = aws_route_table.PubRT.id
  
}

resource "aws_route_table_association" "PrivassRT" {
    for_each = {
        priv1 = aws_subnet.subnetpriv.id
        priv2 = aws_subnet.subnetpriv2.id
    }
    subnet_id = each.value
    route_table_id = aws_route_table.PrivRT.id
}