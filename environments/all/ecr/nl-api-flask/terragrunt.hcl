terraform {
  source = "git::ssh://git@github.com/terraform-aws-modules/terraform-aws-ecr.git//?ref=v1.6.0"
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}

include {
  path = find_in_parent_folders()
}

inputs = {
  repository_name = "nl-api-flask"

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 50 images",
        selection = {
          tagStatus   = "any",
          countType   = "imageCountMoreThan",
          countNumber = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  create_repository_policy = true
}
