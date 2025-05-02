output "router" {
  description = "The created router"
  value       = google_compute_router.router
}

output "router_name" {
  description = "The name of the created router"
  value       = google_compute_router.router.name
}

output "nat" {
  description = "The created NAT gateway"
  value       = google_compute_router_nat.nat
}

output "nat_name" {
  description = "The name of the created NAT gateway"
  value       = google_compute_router_nat.nat.name
}

output "nat_ip_addresses" {
  description = "The external IP addresses assigned to the NAT gateway"
  value       = google_compute_router_nat.nat.nat_ips
}