locals {
  subnets_list = [for k, v in var.subnets : v]
}

resource "google_compute_subnetwork" "subnet_with_logging" {
  for_each      = { for i, subnet in local.subnets_list : subnet.name => subnet }
  project       = var.project_id
  name          = each.value.name
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  network       = var.network_name

  dynamic "secondary_ip_range" {
    for_each = try(each.value.secondary_ip_ranges, [])
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }

  log_config {
    aggregation_interval = var.config.aggregation_interval
    flow_sampling        = var.config.flow_sampling
    metadata             = var.config.metadata
  }

  lifecycle {
    ignore_changes = [
      secondary_ip_range,
    ]
  }

  # This is to avoid recreation of subnets
}