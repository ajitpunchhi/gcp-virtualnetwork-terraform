# This file is part of the Terraform configuration for managing Google Cloud resources.
# It specifies the required Terraform version and the required providers for the configuration.
# The configuration is designed to work with Google Cloud resources using the Google provider.
# It is important to keep the providers up to date to ensure compatibility and access to the latest features.
# The configuration uses the Google provider version 4.0.0 or higher and the Google Beta provider version 4.0.0 or higher.
# The Google provider is used to manage Google Cloud resources, while the Google Beta provider is used for beta features and resources.
# The required version of Terraform is set to 1.0.0 or higher to ensure compatibility with the latest features and improvements.
# The configuration is designed to be used with Terraform 1.0.0 or higher, which includes significant improvements and new features.

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.0.0"
    }
  }
}