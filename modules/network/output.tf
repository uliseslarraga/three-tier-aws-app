output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "pub_subnet_cidr" {
  value = aws_subnet.public_subnet.cidr_block
}

output "pub_subnet_az_id" {
  value = aws_subnet.public_subnet.availability_zone_id
}

output "priv_subnet_cidr" {
  value = aws_subnet.private_subnet.cidr_block
}

output "priv_subnet_az_id" {
  value = aws_subnet.private_subnet.availability_zone_id
}