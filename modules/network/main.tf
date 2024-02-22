# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = merge({Name = "main_${var.environment}"}, var.tags)
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge({Name = "main_iw"}, var.tags)
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, 4)
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  tags = merge({Name = "public-subnet"}, var.tags)
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = cidrsubnet(aws_vpc.main_vpc.cidr_block, 6, 4)
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  tags = merge({Name = "private-subnet"}, var.tags)
}