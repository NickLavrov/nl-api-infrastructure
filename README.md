# nl-api-infrastructure

This repository contains the infrastructure as code setup for the NL API.

## Structure

- `environments`: Contains specific configuration for each environment (e.g., preprod, prod) and shared resources across all environments in the `all` folder.
- `environments/terragrunt.hcl` contains common code for all terragrunt files. This includes s3 backend state and generators for versions.tf and terraform.tf when using terraform modules from third-party sources.
- `modules`: Contains code for custom modules.

## Getting Started

1. Ensure you have Terraform and Terragrunt installed.
2. Navigate to the desired environment's directory (i.e. environments/preprod)
3. Run `terragrunt run-all init` followed by `terragrunt run-all apply`. Since the resources use dependencies explicitly, they will be created in logical order. This takes about 10-15 minutes.
4. To tear down resources, first ensure any resources created in the EKS cluster are destroyed (i.e. ALB's, security groups) since they are managed by controllers in kubernetes. Then run `terragrunt run-all destroy`.

## Resources

- `all`
  - ebs-encryption: Set on AWS account level to ensure default EBS volume encryption.
  - ecr: ECR image repositories.
  - iam-policy, iam-role, oidc-provider: Used for github actions IAM role
- `preprod`
  - argo-helm: Install the argocd helm chart in the EKS cluster. This is the only resource on the cluster that is managed by terraform. The `nl-api-argocd-config` repository should be used for all further cluster resource deployment.
  - eks-cluster: The cluster on which applications are deployed
  - iam: IAM roles to be assumed by service accounts in the cluster for various applications.
  - vpc: The VPC, subnets, IGW, NAT Gateways, and other resources for networking. 

## TODO: Automated deployments

## TODO: Contribution

Follow the typical Git workflow. Ensure to test your changes locally before creating a pull request.
