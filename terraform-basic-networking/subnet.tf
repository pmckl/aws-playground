resource "aws_subnet" "public" {
  count = 3

  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  vpc_id            = aws_vpc.main.id
  tags = {
    "Name" = "public"
    "ManagedBy" = "terraform"
  }
}
resource "aws_subnet" "private" {
  count = 3

  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 4, (length(aws_subnet.public) + count.index))
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  vpc_id            = aws_vpc.main.id
  tags = {
    "Name" = "private"
    "ManagedBy" = "terraform"
  }
}
