resource "aws_ebs_volume" "ebs" {
  availability_zone = "ap-southeast-1a"
  size              = 1
}


resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = aws_instance.PublicEC2.id
}

resource "aws_instance" "PublicEC2" { 
  ami = "ami-0995922d49dc9a17d" 
  availability_zone = "ap-southeast-1a" 
  instance_type = "t2.micro" 
  associate_public_ip_address = "true"
  

tags = { 
    Name = "PublicEC2" 
  }
subnet_id = aws_subnet.public_subnet.id 
  vpc_security_group_ids = [aws_security_group.allow_http.id] 
  depends_on = [aws_vpc.demovpc, aws_subnet.public_subnet] 
}