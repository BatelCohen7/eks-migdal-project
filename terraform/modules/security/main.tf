locals {
  tags = {
    Environment = var.environment
    Project     = "migdal-eks"
    ManagedBy   = "terraform"
    Component   = "security"
  }
}

# Security Group for EKS Control Plane
resource "aws_security_group" "eks_cluster" {
  name        = "${var.cluster_name}-cluster-sg"
  description = "Security group for EKS cluster control plane"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${var.cluster_name}-cluster-sg"
  })
}

# Security Group Rules for Control Plane
resource "aws_security_group_rule" "cluster_ingress_workstation_https" {
  description       = "Allow workstation to communicate with the cluster API Server"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = aws_security_group.eks_cluster.id
}

# Security Group for Worker Nodes
resource "aws_security_group" "eks_nodes" {
  name        = "${var.cluster_name}-node-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${var.cluster_name}-node-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  })
}

# Allow nodes to communicate with each other
resource "aws_security_group_rule" "nodes_internal" {
  description              = "Allow nodes to communicate with each other"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_security_group.eks_nodes.id
}

# Allow worker nodes to communicate with control plane
resource "aws_security_group_rule" "nodes_to_cluster" {
  description              = "Allow worker nodes to communicate with cluster API Server"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster.id
  source_security_group_id = aws_security_group.eks_nodes.id
}

# KMS Key for EKS secrets encryption
resource "aws_kms_key" "eks" {
  description             = "EKS Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = local.tags
}

resource "aws_kms_alias" "eks" {
  name          = "alias/${var.cluster_name}-eks-secrets"
  target_key_id = aws_kms_key.eks.key_id
}

# Network Policies
resource "kubernetes_namespace" "security" {
  metadata {
    name = "security"
    labels = {
      name = "security"
    }
  }
}

# Default Network Policy
resource "kubernetes_network_policy" "default_deny" {
  metadata {
    name      = "default-deny"
    namespace = kubernetes_namespace.security.metadata[0].name
  }

  spec {
    pod_selector {}
    policy_types = ["Ingress", "Egress"]
  }
}

# Pod Security Policies
resource "kubernetes_pod_security_policy" "restricted" {
  metadata {
    name = "restricted"
    annotations = {
      "seccomp.security.alpha.kubernetes.io/allowedProfileNames" = "runtime/default"
      "apparmor.security.beta.kubernetes.io/allowedProfileNames" = "runtime/default"
      "seccomp.security.alpha.kubernetes.io/defaultProfileName"  = "runtime/default"
      "apparmor.security.beta.kubernetes.io/defaultProfileName"  = "runtime/default"
    }
  }

  spec {
    privileged                 = false
    allow_privilege_escalation = false

    volumes = [
      "configMap",
      "emptyDir",
      "projected",
      "secret",
      "downwardAPI",
      "persistentVolumeClaim",
    ]

    run_as_user {
      rule = "MustRunAsNonRoot"
    }

    se_linux {
      rule = "RunAsAny"
    }

    supplemental_groups {
      rule = "MustRunAs"
      ranges {
        min = 1
        max = 65535
      }
    }

    fs_group {
      rule = "MustRunAs"
      ranges {
        min = 1
        max = 65535
      }
    }

    read_only_root_filesystem = true
  }
}