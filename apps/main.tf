
module "network" {
  source = "../modules/network"

  env_prefix      = local.env_prefix
  cidr            = "172.16.0.0/16"
  azs             = data.aws_availability_zones.available.names
  public_subnets  = var.public_subnets
  private_subnets = ["172.16.100.0/24", "172.16.101.0/24"]
}


module "ecr" {
  source = "../modules/ecr"

  image_names = ["password-strength"]
}


module "ecs" {
  source = "../modules/ecs"

  env = var.env_name
}

module "services" {
  source = "../modules/svc"

  cluster_id = module.ecs.cluster_id
  env_prefix = local.env_prefix
  image = var.image
  region = var.region
  sgs_id = [aws_security_group.sg_public_ecs.id]
  subnets_id = module.network.public_subnets
  vpc_id = module.network.vpc_id
}
