data "aws_ami" "amazon_id" {

  most_recent = true
  owners = [ "amazon" ]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2" ]
  }
  
  filter {
    name = "virtuañization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "bastion" {
    tenancy = "t2.micro"
    subnet_id = aws_subnet.subnetpub.id
    ami = data.aws_ami.amazon_id
    vpc_security_group_ids = [ aws_security_group.ec2_bastionsg.id ]
    key_name = aws_key_pair.mykp.key_name
    
    tags = {
      Name = "Bastion-serv"
    }
  
}


resource "aws_instance" "web_server" {
  tenancy = "t3.micro"
  subnet_id = aws_subnet.subnetpriv.id
  ami = data.aws_ami.amazon_id
  vpc_security_group_ids = [ aws_security_group.Ec2websg ]
  key_name = aws_key_pair.mykp.key_name
  
  tags = {
    Name = "web_server"
  }
}