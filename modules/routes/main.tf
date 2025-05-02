resource "google_compute_route" "route" {
  for_each               = { for route in var.routes : route.name => route }
  project                = var.project_id
  name                   = each.value.name
  description            = each.value.description
  network                = var.network_name
  dest_range             = each.value.destination_range
  next_hop_gateway       = each.value.next_hop_gateway != "" ? each.value.next_hop_gateway : null
  next_hop_ip            = each.value.next_hop_ip != "" ? each.value.next_hop_ip : null
  next_hop_instance      = each.value.next_hop_instance != "" ? each.value.next_hop_instance : null
  next_hop_vpn_tunnel    = each.value.next_hop_vpn_tunnel != "" ? each.value.next_hop_vpn_tunnel : null
  next_hop_ilb           = each.value.next_hop_ilb != "" ? each.value.next_hop_ilb : null
  priority               = each.value.priority
  tags                   = length(each.value.tags) > 0 ? each.value.tags : null
}