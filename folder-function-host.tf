locals {
  function_host_files = [
    "host.json",
    "local.settings.json",
    "Properties/serviceDependencies.json",
    "Properties/serviceDependencies.local.json"
  ]
}

resource "github_repository_file" "function_host_files" {

  for_each = toset(local.function_host_files)

  repository          = var.repository
  branch              = var.branch
  file                = "${var.path}/${var.root_namespace}.FunctionHost/${each.key}"
  content             = file("${path.module}/files/RootNamespace.FunctionHost/${each.key}.t4")
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}

locals {
  function_host_code_files = [
    "HealthProbes/LivenessProbe.cs",
    "HealthProbes/ReadinessProbe.cs",
    "PubSub/InternalPublisher.cs",
    "PubSub/InternalSubscriber.cs",
    "Properties/launchSettings.json",
    "Function1.cs",
    "PingModel.cs",
    "Program.cs"
  ]
}

resource "github_repository_file" "function_host_code_files" {

  for_each = toset(local.function_host_code_files)

  repository = var.repository
  branch     = var.branch
  file       = "${var.path}/${var.root_namespace}.FunctionHost/${each.key}"
  content = templatefile("${path.module}/files/RootNamespace.FunctionHost/${each.key}.t4",
    {
      root_namespace = var.root_namespace
    }
  )
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}

resource "github_repository_file" "function_host_project_file" {

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
