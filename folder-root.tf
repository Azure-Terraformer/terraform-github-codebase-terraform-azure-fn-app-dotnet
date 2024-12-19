
resource "github_repository_file" "solution_file" {

  repository = var.repository
  branch     = var.branch
  file       = "${var.path}/${var.root_namespace}.sln"
  content = templatefile("${path.module}/files/RootNamespace.sln.t4",
    {
      root_namespace = var.root_namespace
    }
  )
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}
