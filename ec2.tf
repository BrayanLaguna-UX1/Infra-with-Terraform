data "aws_ami" "amazon_id" {

  most_recent = true
  owners = [ "amazon" ]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2" ]
  }
  
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "bastion" {
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnetpub.id
    ami = data.aws_ami.amazon_id.id
    vpc_security_group_ids = [ aws_security_group.ec2_bastionsg.id ]
    key_name = aws_key_pair.mykp.key_name
    
    tags = {
      Name = "Bastion-serv"
    }
  
}


resource "aws_instance" "web_server" {
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnetpriv.id
  ami = data.aws_ami.amazon_id.id
  vpc_security_group_ids = [ aws_security_group.Ec2websg.id ]
  key_name = aws_key_pair.mykp.key_name
  user_data = ""
  
  tags = {
    Name = "web_server"
  }
}

resource "aws_instance" "web_server2" {
  instance_type = "t3.micro"
  subnet_id = aws_subnet.subnetpriv2.id
  ami = data.aws_ami.amazon_id.id
  vpc_security_group_ids = [aws_security_group.Ec2websg.id]
  key_name = aws_key_pair.mykp.key_name

  tags = {
    Name = "web_server2"
  }
  
}