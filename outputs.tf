# This file contains the output variables for the VPC module


output "network" {
  description = "The created VPC network"
  value       = module.vpc.network
}

output "network_name" {
  description = "The name of the VPC network"
  value       = module.vpc.network_name
}

output "network_id" {
  description = "The ID of the VPC network"
  value       = module.vpc.network_id
}

output "network_self_link" {
  description = "The self-link of the VPC network"
  value       = module.vpc.network_self_link
}

output "subnets" {
  description = "The created subnets"
  value       = module.vpc.subnets
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = module.vpc.subnet_ids
}

output "nat_gateway_ip" {
  description = "The external IP address of the NAT gateway"
  value       = var.create_nat ? module.nat[0].nat_ip_addresses : []
}

output "firewall_rules" {
  description = "The created firewall rules"
  value       = module.firewall.firewall_rules
}

output "routes" {
  description = "The created routes"
  value       = module.routes.routes
}