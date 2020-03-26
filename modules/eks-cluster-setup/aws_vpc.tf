resource "aws_vpc" "prombench-vpc" {
  cidr_block  = "10.0.0.0/16"
}
resource "aws_internet_gateway" "prombench-ig" {
  vpc_id = "${aws_vpc.prombench-vpc.id}"
}

resource "aws_route_table" "prombench-route-table" {
  vpc_id = "${aws_vpc.prombench-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.prombench-ig.id}"
  }
}

## PUBLIC SUBNET 1
resource "aws_subnet" "subnet-1" {
  vpc_id     = "${aws_vpc.prombench-vpc.id}"
  cidr_block = "10.0.0.0/17"
  availability_zone       = "${var.aws_az1}"
}

resource "aws_route_table_association" "rt-association-1" {
  subnet_id      = "${aws_subnet.subnet-1.id}"
  route_table_id = "${aws_route_table.prombench-route-table.id}"
}
resource "aws_eip" "nat-1" {
  vpc        = true
  depends_on = ["aws_internet_gateway.prombench-ig"]
}

resource "aws_nat_gateway" "nat-1" {
  allocation_id = "${aws_eip.nat-1.id}"
  subnet_id     = "${aws_subnet.subnet-1.id}"

  depends_on = ["aws_internet_gateway.prombench-ig"]
}

## PUBLIC SUBNET 2
resource "aws_subnet" "subnet-2" {
  vpc_id     = "${aws_vpc.prombench-vpc.id}"
  cidr_block = "10.0.128.0/17"
  availability_zone       = "${var.aws_az2}"
}
resource "aws_route_table_association" "rt-association-2" {
  subnet_id      = "${aws_subnet.subnet-2.id}"
  route_table_id = "${aws_route_table.prombench-route-table.id}"
}

resource "aws_eip" "nat-2" {
  vpc        = true
  depends_on = ["aws_internet_gateway.prombench-ig"]
}

resource "aws_nat_gateway" "nat-2" {
  allocation_id = "${aws_eip.nat-2.id}"
  subnet_id     = "${aws_subnet.subnet-2.id}"

  depends_on = ["aws_internet_gateway.prombench-ig"]
}

resource "aws_security_group" "prombench-sg" {
  name        = "prombench Security Group"
  vpc_id      = "${aws_vpc.prombench-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-demo"
  }
}