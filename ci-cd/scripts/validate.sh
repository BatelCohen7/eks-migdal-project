#!/bin/bash
set -e

# Validate Kubernetes manifests
echo "Validating Kubernetes manifests..."
for file in k8s/hello-world/*.yaml; do
  if [ -f "$file" ]; then
    echo "Validating $file..."
    kubectl apply --dry-run=client -f "$file"
  fi
done

# Validate Terraform configurations
echo "Validating Terraform configurations..."
cd terraform
terraform init -backend=false
terraform validate
terraform fmt -check

# Check Docker configuration
echo "Validating Dockerfile..."
if [ -f "Dockerfile" ]; then
  docker build --no-cache . -t hello-world:test
fi

echo "Validation completed successfully!"