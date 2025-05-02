# This module creates a VPC network and subnets in Google Cloud Platform (GCP).
# It also includes optional NAT gateway, firewall rules, routes, and flow logs.
# The module is designed to be flexible and customizable, allowing users to specify the project ID, region, network name, subnets, NAT gateway, firewall rules, routes, and flow logs.
# The module uses Terraform to manage the resources and is part of a larger configuration for managing GCP resources.

resource "google_compute_network" "network" {
  project                         = var.project_id
  name                            = var.name
  auto_create_subnetworks         = var.auto_create_subnetworks
  description                     = var.description
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

resource "google_compute_subnetwork" "subnetworks" {
  for_each      = { for subnet in var.subnets : subnet.name => subnet }
  project       = var.project_id
  name          = each.value.name
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  network       = google_compute_network.network.id

  dynamic "secondary_ip_range" {
    for_each = each.value.secondary_ip_ranges
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}