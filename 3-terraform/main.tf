provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "server" {
  ami           = "ami-08e2d37b6a0129927"
  instance_type = "t2.micro"
}
