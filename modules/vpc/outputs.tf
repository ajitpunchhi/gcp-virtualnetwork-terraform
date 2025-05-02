output "network" {
  description = "The created VPC network resource"
  value       = google_compute_network.network
}

output "network_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.network.name
}

output "network_id" {
  description = "The ID of the VPC network"
  value       = google_compute_network.network.id
}

output "network_self_link" {
  description = "The self-link of the VPC network"
  value       = google_compute_network.network.self_link
}

output "subnets" {
  description = "The created subnet resources"
  value       = google_compute_subnetwork.subnetworks
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = { for name, subnet in google_compute_subnetwork.subnetworks : name => subnet.id }
}