#!/bin/bash
set -e

# Variables
NAMESPACE="hello-world"
APP_NAME="hello-world"

# Ensure namespace exists
echo "Creating namespace if not exists..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Apply Kubernetes manifests
echo "Deploying application..."
kubectl apply -f k8s/hello-world/deployment.yaml
kubectl apply -f k8s/hello-world/service.yaml

# Wait for deployment
echo "Waiting for deployment to complete..."
kubectl rollout status deployment/$APP_NAME -n $NAMESPACE --timeout=2m

# Check service
echo "Verifying service..."
kubectl get svc $APP_NAME -n $NAMESPACE

echo "Deployment completed successfully!"