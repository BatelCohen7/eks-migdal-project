# EKS Infrastructure Project with ArgoCD
## Overview
This project implements a production-ready Kubernetes infrastructure on AWS using EKS (Elastic Kubernetes Service) with GitOps principles through ArgoCD. The infrastructure is defined and managed using Infrastructure as Code (IaC) with Terraform, enabling reproducible and version-controlled deployments.
## Architecture
### Core Components

### 1.EKS Cluster

- Managed Kubernetes service on AWS
- VPC with proper networking
- ALB for load balancing


### 2.ArgoCD Integration

- Automated deployment management
- GitOps workflow
- Configuration synchronization


### 3.CI/CD Pipeline

- GitHub Actions for automation
- Infrastructure validation
- Application deployment
- Docker image management



## Infrastructure Components
### Terraform Modules


    terraform/
    ├── modules/
    │   ├── eks/        # EKS cluster configuration
    │   ├── networking/ # VPC and network settings
    │   └── alb/        # Application Load Balancer
    ├── environments/
    │   └── prod/       # Production environment
### Application Structure


    Copyk8s/
    └── hello-world/
        ├── deployment.yaml  # Kubernetes deployment
        ├── service.yaml     # Service configuration
        └── index.html       # Simple hello world page
### CI/CD Configuration


    .github/
    └── workflows/
        ├── infrastructure.yml  # Infrastructure pipeline
        └── application.yml     # Application pipeline
## Setup & Deployment
### Prerequisites

- AWS CLI configured
- Terraform installed
- kubectl installed
- Docker installed
- GitHub account with necessary permissions

### Deployment Steps

#### 1.Infrastructure Setup
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

#### 2.ArgoCD Installation
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

#### 3.Application Deployment

- Push changes to main branch
- ArgoCD will automatically sync and deploy



## CI/CD Pipeline
### Infrastructure Pipeline

- Validates Terraform configurations
- Ensures proper formatting
- Applies infrastructure changes
- Runs on infrastructure file changes

### Application Pipeline

- Builds Docker image
- Validates Kubernetes manifests
- Deploys to EKS via ArgoCD
- Runs on application file changes

## GitHub Repository Configuration
### Required Secrets

- `AWS_ACCESS_KEY_ID: `AWS access key
- `AWS_SECRET_ACCESS_KEY:` AWS secret key
- `DOCKERHUB_USERNAME: `Docker Hub username
- `DOCKERHUB_TOKEN: `Docker Hub access token


## Testing & Validation
### Infrastructure Testing

 ```bash
# Verify EKS cluster
 aws eks describe-cluster --name migdal-eks-cluster

# Check nodes
kubectl get nodes`
```

### Application Testing
```bash
bash
# Check deployments
kubectl get deployments -n hello-world

# Verify service
kubectl get svc -n hello-world`
```
### Monitoring Stack

#### Prometheus & Grafana Integration

- Resource metrics collection
- Real-time visualization
- Custom dashboards for cluster and application monitoring
- Alert configuration for critical metrics



### Security Implementation

#### Network Security

- VPC isolation with security groups
- Network policies for pod communication
- IAM roles with least privilege access


#### Secret Management

- AWS KMS for encryption
- Secure secrets handling
- Access control policies


```bash
Quick Monitoring Check
kubectl get pods -n monitoring
kubectl get svc -n monitoring
```
> Note: These features were added as enhancements to the base project requirements, demonstrating additional DevOps capabilities and best practices.

### Project Requirements Fulfilled`

✅ EKS Cluster creation with custom modules
✅ ALB implementation through Terraform
✅ ArgoCD integration
✅ Simple CI/CD pipeline
✅ Hello World application deployment

### Best Practices Implemented

- Infrastructure as Code
- GitOps methodology
- Automated deployments
- Version control
- Documentation
