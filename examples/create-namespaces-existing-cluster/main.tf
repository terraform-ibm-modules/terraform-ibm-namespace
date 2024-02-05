##################################################################
## Use existing cluster ID
##################################################################

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
}

# Sleep to allow RBAC sync on cluster
resource "time_sleep" "wait_operators" {
  depends_on      = [data.ibm_container_cluster_config.cluster_config]
  create_duration = "5s"
}

##############################################################################
# NAMESPACE
##############################################################################

module "namespace" {
  source     = "../../"
  depends_on = [time_sleep.wait_operators]
  namespaces = var.namespaces
}
