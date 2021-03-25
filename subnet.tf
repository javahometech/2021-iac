# create public subnets

resource "aws_subnet" "public" {
  count      = local.num_of_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr,8,count.index)
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

# create private subnets

resource "aws_subnet" "private" {
  count      = local.num_of_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr,8,count.index + local.num_of_subnets)

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

# create internet gateway for public subnet

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "javahome-ig-${local.ws}"
  }
}

# create route table for public subnets
resource "aws_route_table" "pr" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  # route {
  #   ipv6_cidr_block        = "::/0"
  #   egress_only_gateway_id = aws_egress_only_internet_gateway.foo.id
  # }

  tags = {
    Name = "public-rt-${local.ws}"
  }
}
# associate route table with public subnets
resource "aws_route_table_association" "pub_rt_asso" {
  count = local.num_of_subnets
  subnet_id      = aws_subnet.public.*.id[count.index] 
  route_table_id = aws_route_table.pr.id
}

# Allocate EIP for NAT gateway

resource "aws_eip" "nat" {
  vpc      = true
}

# Create Nat Gateway for private subnets
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.*.id[0]
}


# create route table for private subnets
resource "aws_route_table" "pri" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "private-rt-${local.ws}"
  }
}

# associate private subnets with private route tables

resource "aws_route_table_association" "priv_rt_asso" {
  count = local.num_of_subnets
  subnet_id      = aws_subnet.private.*.id[count.index] 
  route_table_id = aws_route_table.pri.id
}

