terraform {
  source = "git::ssh://git@github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-assumable-role-with-oidc?ref=v5.30.0"
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}

include {
  path = find_in_parent_folders()
}

dependency "oidc-provider" {
  config_path = "../../oidc-provider/github-oidc"
}

dependency "iam-policy" {
  config_path = "../../iam-policy/buildx-upload-to-ecr"
}


inputs = {
  create_role = true

  role_name                      = "github-actions-ecr-push"
  provider_url                   = dependency.oidc-provider.outputs.url
  oidc_fully_qualified_audiences = ["sts.amazonaws.com"]
  oidc_subjects_with_wildcards   = ["repo:NickLavrov/nl-api-flask:*"]
  role_policy_arns               = [dependency.iam-policy.outputs.arn]
}
