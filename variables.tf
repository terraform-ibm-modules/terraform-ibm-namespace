##############################################################################
# Input Variables
##############################################################################

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
