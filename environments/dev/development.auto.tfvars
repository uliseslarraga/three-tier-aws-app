# DO NOT INCLUDE ANY SENSITIVE VALUE

vpc_cidr         = "10.0.0.0/16"
aws_region       = "us-east-2"
environment      = "development"
tags             = {terraform_provisioned = true, env = "development", project = "three-tier-web-app"}
instance_type    = "t2.micro"
desired_capacity = 1
max_size         = 3
min_size         = 1