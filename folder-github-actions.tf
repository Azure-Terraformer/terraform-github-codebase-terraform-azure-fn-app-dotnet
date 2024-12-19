locals {
  files = [
    ".github/workflows/atat-manual-dotnet-integration-tests.yaml",
    ".github/workflows/atat-manual-dotnet-unit-tests.yaml",
    ".github/workflows/atat-pull-request-dotnet-integration-tests.yaml",
    ".github/workflows/atat-pull-request-dotnet-unit-tests.yaml"
  ]
}

resource "github_repository_file" "bulk" {

  count = length(local.files)

  repository = var.repository
  branch     = var.branch
  file       = local.files[count.index]

  # second, replace $TFTPL with $ to make it ${}
  # first escape the existing ${}, this will make github ${{ }} escaped and look like $${{ }}
  content = templatefile("${path.module}/files/${local.files[count.index]}.t4",
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
