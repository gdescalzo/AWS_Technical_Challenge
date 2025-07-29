output "security_group_public_name_output" {
    value = aws_security_group.sg_main.name
}

output "security_group_public_id_output" {
    value = aws_security_group.sg_main.id
}