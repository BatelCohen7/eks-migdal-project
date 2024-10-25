module "eks" {
  source = "../../modules/eks"

  cluster_name    = "migdal-eks-prod"
  environment     = "prod"
  cluster_version = "1.27"
  vpc_id          = module.networking.vpc_id
  subnet_ids      = module.networking.subnet_ids

  node_groups = {
    main = {
      desired_size    = 2
      min_size       = 2
      max_size       = 4
      instance_types = ["t3.medium"]
    }
  }
}