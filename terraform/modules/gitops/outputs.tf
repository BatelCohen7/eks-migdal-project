output "argocd_endpoint" {
  description = "Endpoint URL for ArgoCD UI"
  value       = "${helm_release.argocd.name}-server.${kubernetes_namespace.argocd.metadata[0].name}.svc.cluster.local"
}

output "argocd_namespace" {
  description = "Namespace where ArgoCD is installed"
  value       = kubernetes_namespace.argocd.metadata[0].name
}