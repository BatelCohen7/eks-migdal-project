variable "environment" {
  description = "Environment name (e.g., prod, dev, staging)"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "prometheus_stack_version" {
  description = "Version of the kube-prometheus-stack Helm chart"
  type        = string
  default     = "45.7.1"
}

variable "prometheus_retention" {
  description = "Retention period for Prometheus data"
  type        = string
  default     = "15d"
}

variable "prometheus_storage_size" {
  description = "Storage size for Prometheus"
  type        = string
  default     = "50Gi"
}

variable "grafana_storage_size" {
  description = "Storage size for Grafana"
  type        = string
  default     = "10Gi"
}

variable "grafana_password" {
  description = "Admin password for Grafana"
  type        = string
  sensitive   = true
}