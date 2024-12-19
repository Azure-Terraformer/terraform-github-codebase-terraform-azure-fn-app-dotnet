locals {
  function_main_code_files = [
    "Class1.cs"
  ]
}

resource "github_repository_file" "function_main_code_files" {

  count = length(local.function_main_code_files)

  repository = var.repository
  branch     = var.branch
  file       = "${var.path}/${var.root_namespace}/${local.function_main_code_files[count.index]}"
  content = templatefile("${path.module}/files/RootNamespace/${local.function_main_code_files[count.index]}.t4",
    {
      root_namespace = var.root_namespace
    }
  )
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}

resource "github_repository_file" "function_main_project_file" {

  repository = var.repository
  branch     = var.branch
  file       = "${var.path}/${var.root_namespace}/${var.root_namespace}.csproj"
  content = templatefile("${path.module}/files/RootNamespace/RootNamespace.csproj.t4",
    {
      root_namespace = var.root_namespace
    }
  )
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}
