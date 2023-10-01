# nl-api-infrastructure

This repository contains the infrastructure as code setup for the NL API.

## Structure

- `environments`: Contains specific configuration for each environment (e.g., preprod, prod) and shared resources across all environments in the `all` folder.

## Getting Started

1. Ensure you have Terraform and Terragrunt installed.
2. Navigate to the desired environment's directory.
3. Run `terragrunt init` followed by `terragrunt apply` to provision the infrastructure.

## Resources

- ECR Repository: Located under the `environments/all/ecr` directory.
- TODO: Fill this in as I create resources.

## TODO: Automated deployments

## TODO: Contribution

Follow the typical Git workflow. Ensure to test your changes locally before creating a pull request.
