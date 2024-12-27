# Overview

The Azure Function App Codebase Terraform module streamlines the provisioning and management of a C# .NET source codebase for Azure Functions within a designated GitHub repository. Building upon the foundational Azure Function Core module, it leverages core-provisioned resources as data sources to ensure seamless integration across multiple regional stamps. This module automates the creation and committing of essential source files, project configurations, and GitHub Actions workflows, facilitating efficient deployment, unit testing, and integration testing processes. 

By templating and managing these files through Terraform, the module ensures a consistent, scalable, and maintainable codebase, enabling developers to focus on building robust Azure Functions while maintaining best practices in infrastructure as code (IaC) and continuous integration/continuous deployment (CI/CD).

## Run the Tests

There are Terraform Tests included in this repository. In order to run them you need to setup a `.debug.tfvars` file that includes your GitHub user account's name and email address.

```
github_username = "Your Name"
github_email    = "you@me.com"
```

You need to login to GitHub using the GitHub CLI.

```
gh auth login
```

However, you're not done yet, you need to explicitly allow yourself to delete GitHub repositories.

```
gh auth refresh -h github.com -s delete_repo
```

After that you can run the tests by executing the following from the root folder.

```
terraform init
terraform test -var-file="./tests/.debug.tfvars" -verbose
```

This will execute the `baseline.tftest.hcl`. The setup module creates a new GitHub repository and branch that this module will deploy it's source code files into.

## References

To further enhance your understanding and implementation of Azure Function Apps, the following resources are highly recommended:

### Using Managed Identity Instead of AzureWebJobsStorage to Connect a Function App to Azure Storage
This (blog post)[https://techcommunity.microsoft.com/blog/appsonazureblog/use-managed-identity-instead-of-azurewebjobsstorage-to-connect-a-function-app-to/3657606] provides a comprehensive guide on leveraging Managed Identity for authenticating Azure Function Apps with Azure Storage, eliminating the need for access keys. Implementing Managed Identity enhances security by reducing the exposure of sensitive credentials.

### WEBSITE_RUN_FROM_PACKAGE and WEBSITE_CONTENTAZUREFILECONNECTIONSTRING Best Practices
This [documentation](https://github.com/projectkudu/kudu/wiki/WEBSITE_RUN_FROM_PACKAGE-and-WEBSITE_CONTENTAZUREFILECONNECTIONSTRING-Best-Practices#best-practice) offers an in-depth explanation of the WEBSITE_RUN_FROM_PACKAGE setting, which streamlines the deployment process of Azure Function Apps by enabling package-based deployments. Understanding this setting helps optimize deployment strategies for efficiency and reliability.

### Azure Functions Deployment Technologies
This [Microsoft Learn article](https://learn.microsoft.com/en-us/azure/azure-functions/functions-deployment-technologies?tabs=windows#trigger-syncing) analyzes various deployment options for Azure Functions, providing insights into the advantages and use cases of each method. Evaluating these options aids in selecting the most suitable deployment strategy for your project's requirements.

### App Settings Supported by OS and SKU for Function Apps
This [GitHub wiki page](https://github.com/Azure-Samples/function-app-arm-templates/wiki/App-Settings-for-Function-Apps#app-settings-supported-by-os-and-sku) details the app settings supported by different operating systems and SKUs for Azure Function Apps. Familiarity with these settings ensures that your Function Apps are configured correctly, optimizing performance and compatibility based on the chosen OS and SKU.

### App Insights Configuration within the .NET Solution
This [Microsoft Learning article](https://aka.ms/AAt8mw4) explains how to configure a .NET isolated Azure Functions application to emit its logs and telemetry directly to Azure Application Insights.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository_file.bulk](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.function_host_code_files](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.function_host_files](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.function_host_project_file](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.function_main_code_files](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.function_main_project_file](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.function_test_code_files](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.function_test_project_file](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.gitignore](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.solution_file](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_branch"></a> [branch](#input\_branch) | The branch of the GitHub repository where the workflow YAML file will be committed. | `string` | n/a | yes |
| <a name="input_commit_user"></a> [commit\_user](#input\_commit\_user) | The GitHub identity used to commit the workflow YAML file to the repository.<br><br>This includes:<br>- **name**: The name of the user committing the workflow file.<br>- **email**: The email address of the user committing the workflow file.<br><br>Ensure that the provided Git identity has the necessary permissions to push changes to the specified repository and branch. | <pre>object({<br>    name  = string<br>    email = string<br>  })</pre> | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | The file system path within the repository where the C# .NET solution files and source code will be stored.<br><br>This path determines the directory structure in the repository, organizing configuration files for better manageability. | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | The name of the GitHub repository where the GitHub source code and GitHub Actions workflow YAML file will be created. | `string` | n/a | yes |
| <a name="input_root_namespace"></a> [root\_namespace](#input\_root\_namespace) | The .NET Namespace that will be used to the names of the Visual Studio Solution and Project files as well as the default .NET namespace within the <br>  C# codebase. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_path"></a> [path](#output\_path) | n/a |
<!-- END_TF_DOCS -->