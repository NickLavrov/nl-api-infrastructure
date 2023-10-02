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
  role_name                              = "AmazonEKSLoadBalancerControllerRole"
  attach_load_balancer_controller_policy = true
  oidc_providers = {
    ex = {
      provider_arn               = dependency.cluster.outputs.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}
