resource "aws_instance" "web" {
  ami           = var.web_ami
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.*.id[0]
  key_name = "javahome"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data = file("./files/apache.sh")
  iam_instance_profile = aws_iam_instance_profile.web_s3_profile.name
  tags = {
    Name = "HelloWorld-${local.ws}"
  }
}

# create security group for web servers

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "http for web servers"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "ssh for web servers"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_sg_${local.ws}"
  }
}