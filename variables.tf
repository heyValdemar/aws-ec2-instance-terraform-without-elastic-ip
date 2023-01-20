# AWS management
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

# VPC
variable "aws_vpc_1_cidr_block" {
  description = "VPC CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

# Subnet
variable "aws_subnet_1_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.10.0.0/24"
}

variable "aws_subnet_1_availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "eu-west-1a"
}

variable "aws_subnet_2_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.10.1.0/24"
}

variable "aws_subnet_2_availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "eu-west-1b"
}

# Route
variable "aws_destination_1_cidr_block" {
  description = "Destination CIDR"
  type        = string
  default     = "0.0.0.0/0"
}

# EC2
variable "aws_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "aws_root_volume_size_gb" {
  description = "EC2 root volume size (GB)"
  type        = number
  default     = 80
}

variable "aws_root_volume_type" {
  description = "EC2 root volume type"
  type        = string
  default     = "gp2"
}

variable "aws_ebs_volume_name" {
  description = "EC2 extra ebs volume name"
  type        = string
  default     = "/dev/xvda"
}

variable "aws_ebs_volume_size_gb" {
  description = "EC2 extra ebs volume size (GB)"
  type        = number
  default     = 80
}

variable "aws_ebs_volume_type" {
  description = "EC2 extra ebs volume type"
  type        = string
  default     = "gp2"
}

# Key pair
variable "aws_key_pair_name" {
  description = ""
  type        = string
  default     = "key-pair-1"
}