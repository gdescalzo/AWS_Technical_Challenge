resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnet_map

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

