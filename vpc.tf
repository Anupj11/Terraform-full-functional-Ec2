resource "aws_vpc" "vpc" {

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terra_created"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "public_1st_subnet"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "public_2nd_subnet"
  }
}

resource "aws_route_table" "route_table" {

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "terra_public_routeTB"

  }
}

resource "aws_internet_gateway" "IGW" {

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "terra_IGW"
  }

}

resource "aws_route_table_association" "association_1" {

  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.subnet_1.id

}

resource "aws_route_table_association" "association_2" {
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.subnet_2.id

}