data "kubernetes_all_namespaces" "allns" {
  depends_on = [module.namespace]
}

output "my_namespace_present" {
  value       = contains(data.kubernetes_all_namespaces.allns.namespaces, "my-namespace")
  description = "Returns true if 'my-namespace' namespace is created. Otherwise false"
}

output "my_namespace_2_present" {
  value       = contains(data.kubernetes_all_namespaces.allns.namespaces, "my-namespace-2")
  description = "Returns true if 'my-namespace-2' namespace is created. Otherwise false"
}
