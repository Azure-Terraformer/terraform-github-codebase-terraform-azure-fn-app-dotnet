locals {
  original_yaml    = file("${path.module}/files/.github/workflows/atat-pull-request-terraform-plan.yaml")
  escaped_yaml     = replace(local.original_yaml, "$${", "$$${")
  tf_template_yaml = replace(local.escaped_yaml, "$TFTPL", "$")
}

locals {
  files = [
    ".github/workflows/atat-pull-request-dotnet-integration-tests.yaml",
    ".github/workflows/atat-pull-request-dotnet-unit-tests.yaml"
  ]
}

resource "github_repository_file" "bulk" {

  count = length(local.files)

  repository = var.repository
  branch     = var.branch
  file       = local.files[count.index]
  content = templatestring(
    # second, replace $TFTPL with $ to make it ${}
    replace(
      # first escape the existing ${}, this will make github ${{ }} escaped and look like $${{ }}
      replace(
        file("${path.module}/files/.github/workflows/${local.files[count.index]}.t4"),
        "$${", "$$${"
      ),
      "$TFTPL", "$"
    )
    ,
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
