
# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

# Create a VPC
resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "test" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "test"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_network_interface" "test" {
  subnet_id   = aws_subnet.test.id
  private_ips = ["10.10.10.5"]

  tags = {
    Name = "test network interface"
  }
}

resource "aws_instance" "test" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  availability_zone = "eu-central-1a"

  key_name = "almaz"

  tags = {
    Name = "HelloWorld"
  }

  root_block_device {
    volume_size = "8"
    volume_type = "standard"
    delete_on_termination = true
  }

  network_interface {
    network_interface_id = aws_network_interface.test.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}