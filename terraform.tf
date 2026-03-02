provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "example" {
  cidr_block = ["172.16.0.0/16"]

  tags = {
    Name = "my-vpc"
  }
}
resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = ["172.16.10.0/24"]
  availability_zone = "us-east-2a"

  tags = {
    Name = "public-subnet"
  }
}
resource "aws_instance" "example" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-subnet.id
  
  tags = {
    Name = "my-instance"
  }
}
resource "aws_security_group" "fct" {
  name        = "fct-security-group"
  description = "allows ssh access"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}