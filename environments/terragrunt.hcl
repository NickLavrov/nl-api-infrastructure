remote_state {
  backend = "s3"

  config = {
    bucket                  = "nl-api-terraform"
    dynamodb_table          = "nl-api-terraform-lock"
    encrypt                 = true
    key                     = "${path_relative_to_include()}/terraform.tfstate"
    region                  = "us-west-2"
    skip_bucket_root_access = true
  }
}

# This block creates the file path in the .terragrunt-cache folder so that backend is initialized
generate "terraform" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {}
}
EOF
}

# This block creates the provider that is not in the source module
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "us-west-2"
  default_tags {
   tags = {
     provisioner = "terraform"
   }
 }
}
EOF
}
