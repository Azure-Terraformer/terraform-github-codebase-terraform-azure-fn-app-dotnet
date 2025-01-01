locals {
  github_actions_yaml_files = [
    ".github/workflows/atat-manual-dotnet-deploy.yaml",
    ".github/workflows/atat-manual-dotnet-integration-tests.yaml",
    ".github/workflows/atat-manual-dotnet-unit-tests.yaml",
    ".github/workflows/atat-pull-request-dotnet-integration-tests.yaml",
    ".github/workflows/atat-pull-request-dotnet-unit-tests.yaml"
  ]
}

resource "github_repository_file" "bulk" {

  for_each = toset(local.github_actions_yaml_files)

  repository = var.repository
  branch     = var.branch
  file       = each.key

  # second, replace $TFTPL with $ to make it ${}
  # first escape the existing ${}, this will make github ${{ }} escaped and look like $${{ }}
  content = templatefile("${path.module}/files/${each.key}.t4",
    {
      working_directory = var.path
      root_namespace    = var.root_namespace
    }
  )

  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}

locals {
  merge_original_yaml = file("${path.module}/files/.github/workflows/atat-push-dotnet-deploy.yaml")
}

resource "github_repository_file" "push_deploy" {

  for_each = var.environments

  repository          = var.repository
  branch              = var.branch
  file                = ".github/workflows/atat-push-dotnet-deploy-${each.key}.yaml"
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

  content = templatestring(local.merge_original_yaml,
    {
      environment_name = each.key
    }
  )

}
