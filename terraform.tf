resource "aws_vpc" "example" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "my-subnet"
  }
}

resource "aws_instance" "example" {
  ami           = ami-0f3caa1cf4417e51b
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.example.id

  

  tags = {
    Name = "my-instance"
  }
}