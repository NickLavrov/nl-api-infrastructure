terraform {
  source = "git::ssh://git@github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-role-for-service-accounts-eks?ref=v5.30.0"
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}

include {
  path = find_in_parent_folders()
}

dependency "cluster" {
  config_path = "../../eks-cluster/nl-api-preprod"
}

inputs = {
  role_name                     = "cert-manager-preprod"
  attach_cert_manager_policy    = true
  cert_manager_hosted_zone_arns = ["arn:aws:route53:::hostedzone/Z13Y23GOUY16L3"]
  oidc_providers = {
    ex = {
      provider_arn               = dependency.cluster.outputs.oidc_provider_arn
      namespace_service_accounts = ["cert-manager:cert-manager"]
    }
  }
}

