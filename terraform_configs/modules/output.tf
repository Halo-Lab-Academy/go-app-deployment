output "private_subnet_ids" {

  description = "All subnets in the VPC"
  value       = [for id in aws_subnet.private_subnets : id.id]
}

output "public_subnet_ids" {

  description = "All subnets in the VPC"
  value       = [for id in aws_subnet.public_subnets : id.id]
}

output "security_groups" {
  description = "Security group for the cluster control plane communication with worker nodes"
  value       = join(",", [aws_security_group.control_plane_security_group.arn])
}

output "vpc_id" {
  description = "The VPC Id"
  value       = aws_vpc.vpc.arn
}


output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.eks_cluster.certificate_authority[*].data
# }