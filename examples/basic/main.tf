##############################################################################
# Locals
##############################################################################

locals {
  cluster_name = var.prefix
}


##############################################################################
# Resource Group
##############################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.4.8"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##################################################################
## Create VPC and Cluster where namespaces will be created
##################################################################

resource "ibm_is_vpc" "example_vpc" {
  name           = "${var.prefix}-vpc"
  resource_group = module.resource_group.resource_group_id
  tags           = var.resource_tags
}

resource "ibm_is_subnet" "testacc_subnet" {
  name                     = "${var.prefix}-subnet"
  vpc                      = ibm_is_vpc.example_vpc.id
  zone                     = "${var.region}-2"
  total_ipv4_address_count = 256
  resource_group           = module.resource_group.resource_group_id
}

resource "ibm_resource_instance" "cos_instance" {
  name              = "${var.prefix}-cos"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = module.resource_group.resource_group_id
}

# Lookup the current default kube version
data "ibm_container_cluster_versions" "cluster_versions" {}
locals {
  default_ocp_version = "${data.ibm_container_cluster_versions.cluster_versions.default_openshift_version}_openshift"
}

resource "ibm_container_vpc_cluster" "cluster" {
  name                 = local.cluster_name
  vpc_id               = ibm_is_vpc.example_vpc.id
  kube_version         = local.default_ocp_version
  flavor               = "bx2.4x16"
  worker_count         = "2"
  entitlement          = "cloud_pak"
  cos_instance_crn     = ibm_resource_instance.cos_instance.id
  force_delete_storage = true
  zones {
    subnet_id = ibm_is_subnet.testacc_subnet.id
    name      = "${var.region}-2"
  }
  resource_group_id = module.resource_group.resource_group_id
}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id   = ibm_container_vpc_cluster.cluster.id
  resource_group_id = module.resource_group.resource_group_id
}

# Sleep for 30 secs to allow RBAC sync on cluster
resource "time_sleep" "wait_operators" {
  depends_on      = [data.ibm_container_cluster_config.cluster_config]
  create_duration = "30s"
}

##############################################################################
# NAMESPACE
##############################################################################

module "namespace" {
  source     = "../../"
  depends_on = [time_sleep.wait_operators]
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
