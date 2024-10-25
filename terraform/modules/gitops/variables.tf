module "gitops" {
  source = "../../modules/gitops"

  environment         = "prod"
  github_username     = "BatelCohen7"
  github_repo         = "eks-migdal-project"
}