variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the cluster will be created"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks that can access the EKS cluster API"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # בפרודקשן חשוב להגביל את זה!
}

variable "enable_pod_security_policy" {
  description = "Enable Pod Security Policy"
  type        = bool
  default     = true
}