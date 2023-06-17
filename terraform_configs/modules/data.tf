data "aws_eks_cluster_auth" "eks" {
  name = "${var.project_name}-cluster"
}