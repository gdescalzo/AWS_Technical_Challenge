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
  source = "./modules/routing_table"

  vpc_id           = module.vpc.vpc_id
  igw_id           = module.igw.igw_id
  route_table_name = "main_public_rt"
  public_subnet_map = {
    subnet_az1 = module.subnets.public_subnet_ids[0]
    subnet_az2 = module.subnets.public_subnet_ids[1]
  }
}

module "security_groups" {
  source = "./modules/sg"

  vpc_id            = module.vpc.vpc_id
  ssh_allowed_cidr  = var.ssh_allowed_cidr

  ec2_sg_name = var.ec2_sg_name
  alb_sg_name = var.alb_sg_name
  asg_sg_name = var.asg_sg_name
}

module "iam_roles" {
  source                = "./modules/iam_roles"
  role_name             = "ReadImagesRole"
  policy_arn            = var.iam_policy_arn
  instance_profile_name = "ReadImagesInstanceProfile"
}

module "key_pair" {
  source   = "./modules/key_pair"
  key_name = var.key_name
}

module "ec2_redhat" {
  source               = "./modules/ec2_instance"
  ami_id               = var.redhat_ami_id
  instance_type        = var.redhat_instance_type
  subnet_id            = module.subnets.public_subnet_ids[0]
  security_group_id    = module.security_groups.ec2_sg_id
  iam_instance_profile = var.redhat_iam_instance_profile
  key_name             = module.key_pair.key_name
  instance_name        = "redhat-ec2"
  depends_on           = [module.key_pair]
}



