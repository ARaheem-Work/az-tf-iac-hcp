# az-tf-iac-hcp

This repository manages Azure infrastructure with Terraform and is designed to run from an HCP Terraform VCS-driven workspace.
The source code is stored in this GitHub repository, and a pull request to the `dev` branch triggers a run in the linked HCP Terraform workspace.
That pull request run is plan-only and speculative, which means it previews the proposed changes without modifying Terraform state or applying changes in Azure.

## Purpose

The repo provides a simple environment-based layout for managing Azure resources through reusable Terraform modules.

It is currently set up to:
- keep infrastructure code separated by environment
- run Terraform from HCP Terraform after connecting the repository as a VCS source
- support brownfield adoption by importing existing Azure resources into Terraform state

## Software Requirements

You need the following to use this repository:
- a GitHub repository that HCP Terraform can access through the Terraform GitHub app
- an HCP Terraform organization and workspace configured for VCS-driven runs
- an Azure subscription
- an Azure service principal with permission to manage the target resources

Required HCP Terraform workspace environment variables:
- `ARM_CLIENT_ID`
- `ARM_CLIENT_SECRET`
- `ARM_SUBSCRIPTION_ID`
- `ARM_TENANT_ID`

Terraform configuration requirements currently defined in the repo:
- provider: `azurerm`
- provider version: `4.78.0`

## Implemented Scenarios

The repository currently implements these scenarios:

### 0. Overall best practice of using AzureRM provider
Define AzureRM provider at the root module level rather than at the individual module level.

### 1. Import existing Azure Resources

#### Technical steps involved:
1. Define the Azure resource configuration in Terraform so it matches the existing remote Azure resource.
2. Add an import block that maps the Azure resource ID to the correct Terraform resource address in the HCP Terraform workspace.
3. Push the local branch to the remote repository.
4. Open a pull request against the target branch.
5. Let the pull request trigger the linked HCP Terraform workspace, which runs a speculative plan to show the changes Terraform expects to make.
6. Review the plan output and confirm that the imported resource matches the Terraform configuration.
7. Merge the pull request once the plan is correct.
8. Let the merge trigger the normal HCP Terraform plan and apply workflow.
9. Comment out import blocks after initial import of Azure resource into HCP workspace state.

### 2. Edit an existing Resource settings
#### Technical steps involved:
1. Modify an exisitng Resource configuration
2. Push the local branch to the remote repository.
4. Open a pull request against the target branch.
5. Let the pull request trigger the linked HCP Terraform workspace, which runs a speculative plan to show the changes Terraform expects to make.
6. Review the plan output and confirm that the imported resource matches the Terraform configuration.
7. Merge the pull request once the plan is correct.
8. Let the merge trigger the normal HCP Terraform plan and apply workflow.



### 3. Edit an existing Resource tags

#### Technical steps involved:
1. Modify an exisitng Resource configuration
2. Push the local branch to the remote repository.
4. Open a pull request against the target branch.
5. Let the pull request trigger the linked HCP Terraform workspace, which runs a speculative plan to show the changes Terraform expects to make.
6. Review the plan output and confirm that the imported resource matches the Terraform configuration.
7. Merge the pull request once the plan is correct.
8. Let the merge trigger the normal HCP Terraform plan and apply workflow.


### 4. Create a new resource
#### Technical steps involved:
1. Create Resource configuration
2. Push the local branch to the remote repository.
4. Open a pull request against the target branch.
5. Let the pull request trigger the linked HCP Terraform workspace, which runs a speculative plan to show the changes Terraform expects to make.
6. Review the plan output and confirm that the imported resource matches the Terraform configuration.
7. Merge the pull request once the plan is correct.
8. Let the merge trigger the normal HCP Terraform plan and apply workflow.


### 5. Delete an existing Resource

#### Technical steps involved:
1. Comment out(disable) Resource configuration
2. Push the local branch to the remote repository.
4. Open a pull request against the target branch.
5. Let the pull request trigger the linked HCP Terraform workspace, which runs a speculative plan to show the changes Terraform expects to make.
6. Review the plan output and confirm that the imported resource matches the Terraform configuration.
7. Merge the pull request once the plan is correct.
8. Let the merge trigger the normal HCP Terraform plan and apply workflow.

### 6. Remove a resource from HCP State Only, no changes to Azure rmeote resource

#### Technical steps involved:
1. Comment out(disable) Resource configuration
2. Add the following `removed` block in the same file as original resource block. Source: [Removing a Resource from the Terraform State Using the "removed" block](https://support.hashicorp.com/hc/en-us/articles/34185721057555-Removing-a-Resource-from-the-Terraform-State-Using-the-removed-block).
Terraform code
```
removed {
  from = null_resource.null

  lifecycle {
    destroy = false
  }
}
````



2. Push the local branch to the remote repository.
4. Open a pull request against the target branch.
5. Let the pull request trigger the linked HCP Terraform workspace, which runs a speculative plan to show the changes Terraform expects to make.
6. Review the plan output and confirm that the imported resource matches the Terraform configuration.
7. Merge the pull request once the plan is correct.
8. Let the merge trigger the normal HCP Terraform plan and apply workflow.

### 1. HCP Terraform VCS Integration

The repository is intended to be connected to HCP Terraform as a VCS-backed workspace.

Typical setup flow:
1. In GitHub, allow the Terraform app to access this repository.
2. In HCP Terraform, create a workspace linked to this repository.
3. Add the required Azure authentication variables to the workspace.

Technical steps involved:
1. Connect the GitHub repository to an HCP Terraform workspace as a VCS source.
2. Configure the workspace to watch the target branch used for infrastructure changes.
3. Add the Azure authentication variables so the `azurerm` provider can authenticate during plan and apply runs.
4. Let HCP Terraform execute speculative plans for pull requests before changes are merged.
5. After merge, run the standard Terraform workflow from the linked workspace against the selected environment directory.



## 3. Brownfield Resource Import

The `env/dev/imports.tf` file includes Terraform import blocks for:
- an existing Azure resource group
- an existing Azure Storage Account

This supports onboarding existing Azure resources into Terraform management without recreating them.

Technical steps involved:
1. Define the target resources in Terraform code before importing them.
2. Add import blocks in `env/dev/imports.tf` that map each Azure resource ID to the correct Terraform resource address.
3. Point the import targets to the module-managed resources in `module.az_resource_group.azurerm_resource_group.res-0` and `module.az_storage_account.azurerm_storage_account.res-0`.
4. Run Terraform from the `env/dev` environment so the existing Azure resources are attached to Terraform state.
5. Review the resulting plan to confirm the imported resources match the code and do not require unintended changes.



## Environment Layout

- `env/dev`: implemented environment with modules, provider config, and import definitions
- `env/test`: scaffolded environment, currently empty
- `env/prod`: scaffolded environment, currently empty

## Current Scope Notes

At the moment, only the `dev` environment contains active Terraform resources. The `test` and `prod` folders exist as placeholders for the same pattern but do not yet define resources or imports.
