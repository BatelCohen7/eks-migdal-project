output "prometheus_url" {
  description = "URL for accessing Prometheus"
  value       = "http://prometheus.${kubernetes_namespace.monitoring.metadata[0].name}.svc.cluster.local:9090"
}

output "grafana_url" {
  description = "URL for accessing Grafana"
  value       = "http://grafana.${kubernetes_namespace.monitoring.metadata[0].name}.svc.cluster.local"
}

output "alertmanager_url" {
  description = "URL for accessing AlertManager"
  value       = "http://alertmanager.${kubernetes_namespace.monitoring.metadata[0].name}.svc.cluster.local:9093"
}

output "monitoring_namespace" {
  description = "Kubernetes namespace for monitoring tools"
  value       = kubernetes_namespace.monitoring.metadata[0].name
}