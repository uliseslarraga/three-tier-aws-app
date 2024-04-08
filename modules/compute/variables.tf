data "aws_ami" "web_app_image" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["learn-packer-linux-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "environment" {
  type        = string
  description = "Env name"
}

variable "vpc_id" {
  type        = string
  description = "VPC id from Network module"
}

variable "tags" {
  type        = any
  description = "Common resource tags"
}

variable "instance_type" {
  type        = string
  description = "Instance type used in launch configuration"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of instances for the autoscaling group"
}

variable "max_size" {
  type        = number
  description = "Max number of instances for the autoscaling group"
}

variable "min_size" {
  type        = number
  description = "Min number of instances for the autoscaling group"
} 

variable "private_subnets" {
  type        = any
  description = "Private subnet ids"
}

variable "public_subnets" {
  type        = any
  description = "Public subnet ids"
}