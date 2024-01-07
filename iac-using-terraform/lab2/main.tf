provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_key_pair" "udemy-keypair" {
  key_name   = "udemy-keypair"
  public_key = file("./keypair/udemy-key.pub")
}

resource "aws_instance" "demo-instance" {
  ami           = "ami-0fa377108253bf620" # ami-0e4b5d31e60aa0acd
  instance_type = "t3.medium"
  key_name      = aws_key_pair.udemy-keypair.key_name
  tags = {
    Name = "Udemy Demo"
  }
  vpc_security_group_ids = [aws_security_group.test-security-group.id]
}

resource "aws_security_group" "test-security-group" {
  name        = "test-security-group"
  description = "test-security-group"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
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
}

