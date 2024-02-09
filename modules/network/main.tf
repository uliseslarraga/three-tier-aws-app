# Create a VPC
resource "aws_vpc" "vpc_ulr_test" {
  cidr_block = var.vpc_cidr
  tags = merge({Name = "main_${var.environment}"}, var.tags)
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc_ulr_test.id
  cidr_block = cidrsubnet(aws_vpc.vpc_ulr_test.cidr_block, 8, 4)
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  tags = merge({Name = "public-subnet"}, var.tags)
}