#vpc
resource "aws_vpc" "net-vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
}

#igw
resource "aws_internet_gateway" "net-igw" {
  vpc_id = aws_vpc.net-vpc.id
  tags = {
    Name = "${var.env}-igw"
  }
}

#public subnet
resource "aws_subnet" "public_subnets" {
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  count = length(var.azs)
  vpc_id = aws_vpc.net-vpc.id
  tags = {
    Name = "${var.env}-public_subnet-${count.index+1}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.net-vpc.id
  tags = {
    Name = "${var.env}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = element(aws_subnet.public_subnets.*.id, count.index)
  count = length(var.public_subnets)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route" "public-igw" {
  route_table_id = aws_route_table.public_rt.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id = aws_internet_gateway.net-igw.id
}

#private subnet
resource "aws_subnet" "private_subnets" {
  cidr_block = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]
  count = length(var.azs)
  vpc_id = aws_vpc.net-vpc.id
  tags = {
    Name = "${var.env}-private_subnet-${count.index+1}"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.net-vpc.id
  count = length(var.private_subnet)
  tags = {
    Name = "${var.env}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id = element(aws_subnet.private_subnets.*.id, count.index)
  count = length(var.private_subnets)
  route_table_id = element(aws_route_table.private_rt.*.id, count.index)
}

resource "aws_eip" "eip" {
  domain = "vpc"
  tags = {
    Name = "${var.env}-eip"
  }
}

#nat gateway
resource "aws_nat_gateway" "natgw" {
  count = var.enable_nat_gateway && var.single_nat_gateway ? 1 : 0
  allocation_id = aws_eip.eip.id
  subnet_id = element(aws_subnet.public_subnets.*.id, count.index)
  tags = {
    Name = "${var.env}-natgw"
  }
  depends_on = [ aws_internet_gateway.net-igw ]
}

resource "aws_route" "private_natgw" {
  route_table_id = element(aws_route_table.private_rt.*.id, count.index)
  destination_cidr_block = var.destination_cidr_block
  nat_gateway_id = element(aws_nat_gateway.natgw.*.id, count.index)
  count = length(var.azs)
}