# Namespace module

[![Graduated (Supported)](https://img.shields.io/badge/Status-Graduated%20(Supported)-brightgreen)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-namespace?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-namespace/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

<!-- Add a description of module(s) in this repo -->
This module supports creating multiple Kubernetes namespaces / OpenShift projects with optional annotations and labels.

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-namespace](#terraform-ibm-namespace)
* [Examples](./examples)
    * [Basic example](./examples/basic)
    * [Create Namespace on the existing cluster example](./examples/create-namespaces-existing-cluster)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->

## terraform-ibm-namespace

### Usage

```hcl
##############################################################################
# Init cluster config for kubernetes providers
##############################################################################

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
}

##############################################################################
# Config providers
##############################################################################

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key # pragma: allowlist secret
}

provider "kubernetes" {
  host                   = data.ibm_container_cluster_config.cluster_config.host
  token                  = data.ibm_container_cluster_config.cluster_config.token
  cluster_ca_certificate = data.ibm_container_cluster_config.cluster_config.ca_certificate
}

##############################################################################
# Namespace module
##############################################################################

# Replace "main" with a GIT release version to lock into a specific release
module "namespace" {
  source            = "terraform-ibm-modules/namespace/ibm"
  version           = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific
  namespaces = [
    {
      name = "my-namespace"
      metadata = {
        labels = {
          "istio-injection" = "enabled"
        }
        annotations = {
          "name" = "example-annotation"
        }
      }
    },
    {
      name = "my-namespace-2"
      metadata = {
        labels = {
          "istio-injection" = "enabled"
        }
        annotations = {
          "name" = "example-annotation"
        }
      }
    }
  ]
}
```

### Required IAM access policies

You need the following permissions to run this module.

- IAM Services
  - **Kubernetes** service
      - `Viewer` platform access
      - `Manager` service access

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, <1.6.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.16.1, < 3.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.create_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespaces"></a> [namespaces](#input\_namespaces) | Set of namespaces to create | <pre>list(object({<br>    name = string<br>    metadata = optional(object({<br>      labels      = map(string)<br>      annotations = map(string)<br>    }))<br>  }))</pre> | n/a | yes |

### Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
