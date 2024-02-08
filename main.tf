##############################################################################
# Namespace module
#
# Creates kubernetes namespaces
##############################################################################

resource "kubernetes_namespace" "create_namespace" {
  for_each = { for namespace in var.namespaces : namespace.name => namespace }
  metadata {
    name        = each.value.name
    annotations = try(each.value.metadata.annotations, {})
    labels      = try(each.value.metadata.labels, {})
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels
    ]
  }
}
