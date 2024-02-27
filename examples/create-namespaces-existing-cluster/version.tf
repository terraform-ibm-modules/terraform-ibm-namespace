terraform {
  required_version = ">= 1.3.0, <1.7.0"
  required_providers {
    # Pin to the lowest provider version of the range defined in the main module to ensure lowest version still works
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.58.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}
