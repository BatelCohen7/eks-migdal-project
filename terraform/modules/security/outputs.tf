output "cluster_security_group_id" {
  description = "Security group ID for the EKS cluster"
  value       = aws_security_group.eks_cluster.id
}

output "node_security_group_id" {
  description = "Security group ID for the EKS worker nodes"
  value       = aws_security_group.eks_nodes.id
}

output "kms_key_arn" {
  description = "ARN of KMS key for EKS secrets encryption"
  value       = aws_kms_key.eks.arn
}