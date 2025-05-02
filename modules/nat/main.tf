resource "google_compute_router" "router" {
  name    = "${var.nat_name}-router"
  project = var.project_id
  region  = var.region
  network = var.network_name
}

resource "google_compute_router_nat" "nat" {
  name                                = var.nat_name
  project                             = var.project_id
  router                              = google_compute_router.router.name
  region                              = var.region
  nat_ip_allocate_option              = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat  = var.source_subnetwork_ip_ranges_to_nat
  min_ports_per_vm                    = var.min_ports_per_vm
  nat_ips                             = var.nat_ips
  enable_endpoint_independent_mapping = var.enable_endpoint_independent_mapping
  enable_dynamic_port_allocation      = var.enable_dynamic_port_allocation

  dynamic "log_config" {
    for_each = var.log_config.enable ? [1] : []
    content {
      enable = true
      filter = var.log_config.filter
    }
  }

  dynamic "subnetwork" {
    for_each = var.source_subnetwork_ip_ranges_to_nat == "LIST_OF_SUBNETWORKS" ? var.subnetworks : []
    content {
      name                     = subnetwork.value
      source_ip_ranges_to_nat  = ["ALL_IP_RANGES"]
    }
  }
}