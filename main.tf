module "vpc" {
  source     = "./modules/vpc"
  vpc_name   = var.vpc_name
  cidr_block = var.cidr_block
}

module "subnets" {
  source = "./modules/subnets"

  vpc_id = module.vpc.vpc_id

  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  public_subnet_azs  = var.public_subnet_azs
  private_subnet_azs = var.private_subnet_azs
}

module "igw" {
  source   = "./modules/igw"
  vpc_id   = module.vpc.vpc_id
  igw_name = var.igw_name
}

module "routing_table" {
  source             = "./modules/routing_table"
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.igw.igw_id
  public_subnet_ids  = module.subnets.public_subnet_ids
  route_table_name   = "main_public_rt"
}
