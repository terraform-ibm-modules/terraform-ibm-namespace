terraform {
  required_version = ">= 1.3.0, <1.7.0"
  required_providers {
    # Use "greater than or equal to" range in modules
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.1, < 3.0.0"
    }
  }
}
