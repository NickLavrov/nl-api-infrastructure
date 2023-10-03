terraform {
  source = "git::ssh://git@github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-github-oidc-provider?ref=v5.30.0"
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}

include {
  path = find_in_parent_folders()
}

# From the module source:
# Note: an IAM provider is 1 per account per given URL. This module would be provisioned once per AWS account, and multiple roles created with this provider as the trusted identity (typically 1 role per GitHub repository).
inputs = {
}
