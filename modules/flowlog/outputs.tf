output "subnets" {
  description = "The subnets with flow logs enabled"
  value       = google_compute_subnetwork.subnet_with_logging
}