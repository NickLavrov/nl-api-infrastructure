terraform {
  source = "git::ssh://git@github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-role-for-service-accounts-eks?ref=v5.30.0"
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}

include {
  path = find_in_parent_folders()
}

inputs = {
  role_name                              = "AmazonEKSLoadBalancerControllerRole"
  attach_load_balancer_controller_policy = true
  oidc_providers = {
    ex = {
      provider_arn               = "arn:aws:iam::825391943801:oidc-provider/oidc.eks.us-west-2.amazonaws.com/id/68B81C755684567BB61F73987CBA3912"
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}
