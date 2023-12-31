terraform {
  source = "../../../modules//argocd-helm"

  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}

include {
  path = find_in_parent_folders()
}

dependency "cluster" {
  config_path = "../eks-cluster/nl-api-preprod"
}

inputs = {
  cluster_name = dependency.cluster.outputs.cluster_name
}
