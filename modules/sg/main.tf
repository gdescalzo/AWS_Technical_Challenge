resource "aws_security_group" "sg_main" {
    name = "AllowTraffic_80-443-22-3389_ports"
    vpc_id = var.vpc_id

    dynamic "ingress" {
        iterator = port
        for_each = var.security_group_public_ingress
        content {
          from_port = port.value
          to_port = port.value
          protocol = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        }      
    }

    dynamic "egress" {
        iterator = port
        for_each = var.security_group_public_egress
        content {
          from_port = port.value
          to_port = port.value
          protocol = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        }      
    }  
}