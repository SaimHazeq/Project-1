module "vpc" {
  source = "./vpc"
}

module "ecr" {
  source = "./ecr"
}

module "eks" {
  source = "./eks"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}
