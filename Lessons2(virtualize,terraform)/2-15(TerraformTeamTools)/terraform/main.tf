
# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


#resource "aws_instance" "web" {
#  ami           = data.aws_ami.ubuntu.id
#  instance_type = "t2.micro"
#  availability_zone = "eu-central-1a"
#
#  lifecycle {
#     create_before_destroy = true
#  }
#}
