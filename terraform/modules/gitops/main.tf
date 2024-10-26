locals {
  tags = {
    Environment = var.environment
    Project     = "migdal-eks"
    ManagedBy   = "terraform"
    Component   = "gitops"
  }
}

# 1. Set up nameSpace to ArgoCD
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
    labels = {
      environment = var.environment
    }
  }
}

# 2. Install ArgoCD using Helmresource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  version          = var.argocd_chart_version
  create_namespace = false

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "server.extraArgs[0]"
    value = "--insecure"  # לסביבת פיתוח בלבד
  }
}

# 3. Set up the Heello World app at ArgoCD
resource "kubernetes_manifest" "hello_world_app" {
  depends_on = [helm_release.argocd]

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "hello-world"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/${var.github_username}/${var.github_repo}"
        targetRevision = "main"
        path           = "k8s/hello-world"
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "hello-world"
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = ["CreateNamespace=true"]
      }
    }
  }
}