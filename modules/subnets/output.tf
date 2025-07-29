output "subnet_public_id" {
    value = aws_subnet.public_subnets.id
}

output "subnet_private_id" {
    value = aws_subnet.private_subnet.id
}