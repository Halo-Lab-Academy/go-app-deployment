resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.project_name}-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.25"

  vpc_config {
    subnet_ids              = concat([for ids in aws_subnet.private_subnets : ids.id], [for ids in aws_subnet.private_subnets : ids.id])
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_subnet.private_subnets,
    aws_subnet.public_subnets
  ]
}

resource "aws_eks_fargate_profile" "fargate_profile" {
  cluster_name           = aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = var.namespace
  pod_execution_role_arn = aws_iam_role.fargate_profile_role.arn
  subnet_ids             = concat([for ids in aws_subnet.private_subnets : ids.id], [for ids in aws_subnet.private_subnets : ids.id])

  selector {
    namespace = var.namespace
  }
}