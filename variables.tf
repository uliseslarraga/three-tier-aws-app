variable "aws_region" {
  description = "region name"
  type        = string
}

variable "tags" {
  type        = any
  description = "Common resource tags"
}

variable "environment" {
  type        = string
  description = "Env name"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR to be used for the new VPC"
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
