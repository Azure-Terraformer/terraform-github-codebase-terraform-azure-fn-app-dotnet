locals {
  function_test_code_files = [
    "IntegrationTests.cs",
    "UnitTests.cs"
  ]
}

resource "github_repository_file" "function_test_code_files" {

  for_each = toset(local.function_test_code_files)

  repository = var.repository
  branch     = var.branch
  file       = "${var.path}/${var.root_namespace}.Tests/${each.key}"
  content = templatefile("${path.module}/files/RootNamespace.Tests/${each.key}.t4",
    {
      root_namespace = var.root_namespace
    }
  )
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}

resource "github_repository_file" "function_test_project_file" {

  repository = var.repository
  branch     = var.branch
  file       = "${var.path}/${var.root_namespace}.Tests/${var.root_namespace}.Tests.csproj"
  content = templatefile("${path.module}/files/RootNamespace.Tests/RootNamespace.Tests.csproj.t4",
    {
      root_namespace = var.root_namespace
    }
  )
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}
