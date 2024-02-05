variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Token"
  sensitive   = true
}

variable "prefix" {
  type        = string
  description = "Prefix to give all resources created by this example"
  default     = "namespace-test"
}

variable "region" {
  type        = string
  description = "Region where resources are created"
  default     = "ca-tor"
}

variable "resource_group" {
  type        = string
  description = "An existing resource group name to use for this example, if unset a new resource group will be created"
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources"
  default     = []
}
