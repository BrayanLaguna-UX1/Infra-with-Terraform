
resource "tls_private_key" "genekp" {
    algorithm = "RSA"
    rsa_bits = 4096
  
}


resource "aws_key_pair" "mykp" {
    public_key = tls_private_key.genekp.public_key_openssh
    tags = {
      Name = "Ec2_keypair"
    }
  
}

resource "local_file" "saveprivkey" {
    content = tls_private_key.genekp.private_key_pem
    filename = "${path.module}/pvk1.pem"
    file_permission = "0400"
  
}