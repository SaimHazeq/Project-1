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

# AUTH CONFIG
manage_aws_auth_configmap = true

  aws_auth_users = [
    {
      userarn  = "var.admin_user_arn"
      username = "admin"
      groups   = ["system:masters"]
    }
  ]

# NODE ROLE MAPPING
  aws_auth_roles = [
    {
      rolearn  = module.eks.eks_managed_node_groups["default"].iam_role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = [
        "system:bootstrappers",
        "system:nodes"
      ]
    }
  ]

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

