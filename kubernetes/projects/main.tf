terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.18.1"
    }
  }
}

data "aws_caller_identity" "current" {}

provider "kubernetes" {
  # Configuration options

  config_path    = "~/.kube/config"
  # config_context = "arn:aws:eks:us-east-1:${data.aws_caller_identity.current.id}:cluster/hello-world-go-app-cluster"
  config_context = "minikube"
}

module "k8s-configs" {
  source     = "../modules"
  tag        = "latest"
  image_name = "${data.aws_caller_identity.current.id}.dkr.ecr.us-east-1.amazonaws.com/hello-world-go-app"
}