variable "vpc_block" {
  description = "The CIDR range for the VPC. This should be a valid private (RFC 1918) CIDR range."
  type        = string
}

variable "private_subnet_block" {
  description = "CidrBlock for private subnet 01 within the VPC"
  type        = map(any)
}


variable "public_subnet_block" {
  description = "CidrBlock for public subnet within the VPC"
  type        = map(any)
}

variable "project_name" {
  description = "The name of this project"
  type        = string
}

variable "namespace" {
  description = "EKS Fargate namespace"
  type        = string
  default     = "kube-system"
}