module "vpc" {
  source = "./vpc"

  project_name = var.project_name
}

module "ecr" {
  source = "./ecr"

  project_name = var.project_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project_name}-eks"
  cluster_version = "1.33"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  enable_irsa = true

access_entries = {
  admin = {
    principal_arn = arn:aws:iam::047719648578:user/saimIAM

    policy_associations = {
      admin = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type = "cluster"
        }
      }
    }
  }
}

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3

      subnet_ids = module.vpc.private_subnets
    }
  }
  depends_on = [module.vpc]
}

