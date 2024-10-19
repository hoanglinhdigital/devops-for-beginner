# Define the provider
provider "aws" {
  region = "us-west-2"
}

# Create a new EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  tags = {
    Name = "example-instance"
  }
}

# Create an EBS volume
resource "aws_ebs_volume" "example_volume" {
  availability_zone = aws_instance.example.availability_zone
  size              = 100
}

# Attach the EBS volume to the instance
resource "aws_volume_attachment" "example_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.example_volume.id
  instance_id = aws_instance.example.id
}

