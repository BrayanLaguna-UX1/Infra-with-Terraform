resource "aws_vpc" "myvpc" {
    cidr_block = "10.10.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "Vpc-tf1"
    }
}

resource "aws_internet_gateway" "myitg" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "onlyigw"
    }
  
}

resource "aws_nat_gateway" "mynat" {
    subnet_id = aws_subnet.subnetpub.id
    allocation_id = aws_eip.eipfornat.id
    tags = {
      Name = "natgate1"
    }
  
}


resource "aws_eip" "eipfornat" {
    domain = "vpc"  
}