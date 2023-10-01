terraform {
  source = "git::ssh://git@github.com/terraform-aws-modules/terraform-aws-vpc.git//?ref=v5.1.2"
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name               = "preprod-vpc"
  region             = "us-west-2"
  cidr               = "10.0.0.0/16"
  azs                = ["us-west-2a", "us-west-2b"]
  private_subnets    = ["10.0.0.0/18", "10.0.64.0/18"]
  public_subnets     = ["10.0.128.0/18", "10.0.192.0/18"]
  enable_nat_gateway = true
  create_igw         = true
  tags = {
    provisioner = "terraform"
  }
}
