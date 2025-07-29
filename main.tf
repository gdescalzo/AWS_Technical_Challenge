provider "aws" {
    region  = var.aws_region
}
module "module_vpc" {
  source = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  vpc_name = var.vpc_name  
}

module "module_subnets" {
  source = "./modules/subnets"
  vpc_id = module.module_vpc.vpc_id

  # Public Subnet
  subnet_public_name = var.subnet_public_name
  subnet_public_cidr = var.subnet_public_cidr
  az_subnet_public = var.az_subnet_public

  #Private Subnet
  subnet_private_name = var.subnet_private_name
  subnet_private_cidr = var.subnet_private_cidr
  az_subnet_private = var.az_subnet_privated
}

module "module_igw" {
  source = "./modules/igw"
  vpc_id = module.module_vpc.vpc_id
  igw_name = var.igw_name
}

module "module_routing_table" {
  source = "./modules/routing_table"
  vpc_id = module.module_vpc.vpc_id
  public_routing_table_name = var.igw_name
  igw_id = module.module_igw.igw_id
  subnet_public_id = module.module_subnets.subnet_public_id
}

module "module_security_groups" {
  vpc_id = module.module_vpc.vpc_id
  source = "./modules/sg"
  security_group_public_ingress = var.security_group_public_ingress
  security_group_public_egress = var.security_group_public_egress
}