variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "oidc_provider" {
  description = "OIDC provider URL for EKS"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN for EKS"
  type        = string
}