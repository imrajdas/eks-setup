provider "aws" {
  region = "us-east-1"
}

module "eks-cluster-setup" {
  source  = "modules/eks-cluster-setup"
}