resource "aws_subnet" "subnetpriv" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.10.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Privsub1"
    }
}

resource "aws_subnet" "subnetpriv2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.10.3.0/24"
    availability_zone = "us-east-1c"
    tags = {
        Name = "Privsub2"
    }
}

resource "aws_subnet" "subnetpub" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.10.2.0/24"
    availability_zone = "us-east-1b"
    
    
    tags = {
        Name = "publicsub1"
    }
}

resource "aws_subnet" "subnetpub2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.10.4.0/24"
    availability_zone = "us-east-1f"
    tags = {
        Name = "Publicsub2"
    }
}