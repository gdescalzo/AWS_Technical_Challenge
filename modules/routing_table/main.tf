resource "aws_route_table" "public_routing_table" {
    vpc_id = var.vpc_id

    tags = {
        Name = var.public_routing_table_name
    }
}

resource "aws_route" "internet_route" {
    route_table_id = aws_route_table.public_routing_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
}

resource "aws_route_table_association" "routing_table_public_association" {
    subnet_id = var.subnet_public_id
    route_table_id = aws_route_table.public_routing_table.id  
}