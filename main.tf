# AWS region
provider "aws" {
  region = var.aws_region
}

# Get AMI ID for Ubuntu Focal Fossa 20.04
data "aws_ami" "ubuntu_20_04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  # Ubuntu AMI ID searching
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get AMI ID for Ubuntu Jammy Jellyfish 22.04
data "aws_ami" "ubuntu_22_04" {
  most_recent = true
  owners      = ["099720109477"]

  # Ubuntu AMI ID searching
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}