resource "aws_subnet" "public_subnets" {
    vpc_id     = var.vpc_id
    cidr_block = var.subnet_public_cidr
    availability_zone = var.az_subnet_public
 
 tags = {
   Name = var.subnet_public_name
 }
}

resource "aws_subnet" "private_subnet" {
    vpc_id     = var.vpc_id
    cidr_block = var.subnet_private_cidr
    availability_zone = var.az_subnet_private
 
 tags = {
   Name = var.subnet_private_name
 }
}