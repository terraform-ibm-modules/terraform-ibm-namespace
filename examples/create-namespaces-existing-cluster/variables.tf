variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Token"
  sensitive   = true
}

variable "cluster_id" {
  description = "Cluster name or id to create namespace in"
  type        = string
}

variable "region" {
  type        = string
  description = "Region where resources are created"
  default     = "ca-tor"
}

variable "namespaces" {
  type = list(object({
    name = string
    metadata = optional(object({
      labels      = map(string)
      annotations = map(string)
    }))
  }))
  description = "Set of namespaces to create"
}
