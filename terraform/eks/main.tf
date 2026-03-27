module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"
  cluster_name    = "devops-eks"
  cluster_version = "1.29"

  subnet_ids = var.subnet_ids
  vpc_id     = var.vpc_id

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      instance_types   = ["t3.medium"]
    }
  }
}
