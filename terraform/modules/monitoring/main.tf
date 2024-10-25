locals {
  tags = {
    Environment = var.environment
    Project     = "migdal-eks"
    ManagedBy   = "terraform"
    Component   = "monitoring"
  }
}

# Namespace for monitoring tools
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
    labels = {
      name        = "monitoring"
      environment = var.environment
    }
  }
}

# ConfigMap for Prometheus rules
resource "kubernetes_config_map" "prometheus_rules" {
  metadata {
    name      = "prometheus-rules"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }

  data = {
    "alert.rules" = file("${path.module}/files/alert.rules.yml")
  }
}

# Deploy Prometheus Stack via Helm
resource "helm_release" "prometheus_stack" {
  name             = "prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = kubernetes_namespace.monitoring.metadata[0].name
  version          = var.prometheus_stack_version
  create_namespace = false

  values = [
    templatefile("${path.module}/templates/prometheus-values.yaml", {
      cluster_name              = var.cluster_name
      environment              = var.environment
      prometheus_retention     = var.prometheus_retention
      prometheus_storage_size  = var.prometheus_storage_size
      grafana_storage_size    = var.grafana_storage_size
    })
  ]

  set_sensitive {
    name  = "grafana.adminPassword"
    value = var.grafana_password
  }
}