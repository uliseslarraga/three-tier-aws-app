output "vpc_id" {
  value = aws_vpc.vpc_ulr_test.id
}

output "pub_subnet_cidr" {
  value = aws_subnet.public_subnet.cidr_block
}

output "pub_subnet_az_id" {
  value = aws_subnet.public_subnet.availability_zone_id
}