terraform {
  source = "git::ssh://git@github.com/terraform-aws-modules/terraform-aws-eks.git//?ref=v19.16.0"
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc/preprod-vpc"
}

inputs = {
  cluster_name    = "nl-api-preprod"
  cluster_version = "1.28"

  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["192.184.181.107/32"]

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    blue = {
      min_size     = 0
      max_size     = 1
      desired_size = 0

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
    }
    green = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      ami_type       = "AL2_ARM_64"
      instance_types = ["t4g.large"]
      capacity_type  = "SPOT"

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = 20
            volume_type = "gp3"
          }
        }
      }
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = false

  tags = {
    environment = "preprod"
  }
}
