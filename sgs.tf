#SG for ALB
resource "aws_security_group" "albsg" {
    name = "alb_sgroup"
    vpc_id = aws_vpc.myvpc.id
    description = "allow ingress http rule for load balancer"
  
}

resource "aws_vpc_security_group_ingress_rule" "ingressalb" {
    security_group_id = aws_security_group.albsg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
  
}


resource "aws_vpc_security_group_egress_rule" "egressalb" {
    security_group_id = aws_security_group.albsg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"

  
}

#SG for EC2 BASTION

resource "aws_security_group" "ec2_bastionsg" {
  name = "ec2bastion_sg"
  description = "Security group for the Ec2 bastion server. It will allow Connection to internet."
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_vpc_security_group_ingress_rule" "ec2_bastingss" {
    security_group_id = aws_security_group.ec2_bastionsg.id
    cidr_ipv4 = "my_ip"
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
  
}

resource "aws_vpc_security_group_egress_rule" "" {
  security_group_id = aws_security_group.ec2_bastionsg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}


#SGs for web ec2 instance, http and ssh

resource "aws_security_group" "Ec2websg" {
    name = "ec2_websg"
    description = "security groups for the ec2 instance that will host the web"
    vpc_id = aws_vpc.myvpc.id
  
}

resource "aws_vpc_security_group_ingress_rule" "Ec2webingss" {
    security_group_id = aws_security_group.Ec2websg.id
    referenced_security_group_id = aws_security_group.albsg.id
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
  
}

resource "aws_vpc_security_group_ingress_rule" "Ec2webingss_bastion" {
    security_group_id = aws_security_group.Ec2websg.id
    referenced_security_group_id = aws_security_group.ec2_bastionsg.id
    ip_protocol = "tcp"
    from_port = 22
    to_port = 22
}


resource "aws_vpc_security_group_egress_rule" "Ec2webegrss" {
    security_group_id = aws_security_group.Ec2websg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
  
}
