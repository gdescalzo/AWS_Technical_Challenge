vpc_name             = "main_vpc"
cidr_block           = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.0.0/24", "10.1.1.0/24"]
private_subnet_cidrs = ["10.1.2.0/24", "10.1.3.0/24"]
public_subnet_azs    = ["us-east-1a", "us-east-1b"]
private_subnet_azs   = ["us-east-1a", "us-east-1b"]
igw_name             = "main_igw"
#redhat_ami_id        = "ami-0798efca94a4b7e2a" 
ssh_allowed_cidr = "0.0.0.0/0"
ec2_sg_name = "ec2-sg"
alb_sg_name = "alb-sg"
asg_sg_name = "asg-sg"

