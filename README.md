# EKS Infrastructure with ArgoCD

## Overview
This project implements a production-ready Kubernetes infrastructure on AWS using EKS (Elastic Kubernetes Service) with GitOps principles through ArgoCD. The infrastructure is defined and managed using Infrastructure as Code (IaC) with Terraform, enabling reproducible and version-controlled deployments.

## Architecture

### Infrastructure Components
- **EKS Cluster**: Managed Kubernetes service on AWS
- **VPC**: Dedicated Virtual Private Cloud with public subnets
- **Node Group**: Auto-scaling EC2 instances for running workloads
- **IAM Roles**: Secure access management for cluster operations
- **ArgoCD**: GitOps continuous delivery tool for Kubernetes

### Technical Stack
- **Infrastructure**: AWS EKS
- **IaC**: Terraform
- **GitOps**: ArgoCD
- **CI/CD**: Basic pipeline with "Hello World" application
- **Networking**: AWS VPC with public subnets

## Project Structure
```
.
├── README.md
├── main.tf           # Main Terraform configuration
├── variables.tf      # Variable definitions
├── outputs.tf        # Output configurations
└── .gitignore       # Git ignore file
```

## Features
- Automated EKS cluster provisioning
- Secure networking setup with VPC
- GitOps-based deployment workflow
- Scalable node group configuration
- Infrastructure state management
- Basic CI/CD pipeline implementation

## Prerequisites
- AWS Account with appropriate permissions
- Terraform (v1.0.0+)
- AWS CLI configured
- kubectl installed
- Git installed

## Usage

### Infrastructure Deployment
1. Initialize Terraform:
```bash
terraform init
```

2. Review the deployment plan:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

### ArgoCD Setup
1. Install ArgoCD on the cluster
2. Configure Git repository
3. Deploy sample application

## Security Considerations
- EKS cluster with IAM authentication
- Network security with VPC configuration
- Role-based access control (RBAC)
- Secure secrets management

## Contributing
Feel free to open issues and pull requests for any improvements.

## License
This project is licensed under the MIT License - see the LICENSE file for details
