# # This file is used to configure the providers for the Terraform project.
# # It specifies the required providers and their versions.
# # It also sets up the Google Cloud provider with the necessary credentials.
# # The providers are used to create and manage resources in Google Cloud.


terraform {
  required_version = ">= 1.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.26, < 7"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.26, < 7"
    }
  }
