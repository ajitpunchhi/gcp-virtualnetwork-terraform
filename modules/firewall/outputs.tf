output "firewall_rules" {
  description = "The created firewall rules"
  value       = google_compute_firewall.rules
}