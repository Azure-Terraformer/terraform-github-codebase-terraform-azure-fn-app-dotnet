locals {
  function_host_files = [
    "host.json",
    "local.settings.json",
    "Properties/launchSettings.json",
    "Properties/serviceDependencies.json",
    "Properties/serviceDependencies.local.json"
  ]
}

resource "github_repository_file" "function_host_files" {

  count = length(local.function_host_files)

  repository          = var.repository
  branch              = var.branch
  file                = "${var.path}/${var.root_namespace}.FunctionHost/${local.function_host_files[count.index]}"
  content             = file("${path.module}/files/RootNamespace.FunctionHost/${local.function_host_files[count.index]}.t4")
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}

locals {
  function_host_code = [
    "Function1.cs",
    "Program.cs",
    "Startup.cs"
  ]
}

resource "github_repository_file" "function_host_files" {

  count = length(local.function_host_files)

  repository = var.repository
  branch     = var.branch
  file       = "${var.path}/${var.root_namespace}.FunctionHost/${local.function_host_files[count.index]}"
  content = templatefile("${path.module}/files/RootNamespace.FunctionHost/${local.function_host_files[count.index]}.t4",
    {
      root_namespace = var.root_namespace
    }
  )
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}

resource "github_repository_file" "project_file" {

  repository = var.repository
  branch     = var.branch
  file       = "${var.path}/${var.root_namespace}.FunctionHost/${var.root_namespace}.FunctionHost.csproj"
  content = templatefile("${path.module}/files/RootNamespace.FunctionHost/RootNamespace.FunctionHost.csproj.t4",
    {
      root_namespace = var.root_namespace
    }
  )
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}
