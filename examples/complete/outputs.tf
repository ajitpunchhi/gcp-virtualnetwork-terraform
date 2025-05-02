output "network_name" {
  description = "The name of the VPC network"
  value       = module.networking.network_name
}

output "network_self_link" {
  description = "The self-link of the VPC network"
  value       = module.networking.network_self_link
}

output "subnets" {
  description = "The created subnets"
  value       = module.networking.subnets
}

output "nat_gateway_ip" {
  description = "The external IP address of the NAT gateway"
  value       = module.networking.nat_gateway_ip
}

output "firewall_rules" {
  description = "The created firewall rules"
  value       = module.networking.firewall_rules
}

output "routes" {
  description = "The created routes"
  value       = module.networking.routes
}