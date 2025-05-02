# This Terraform configuration sets up a VPC network in Google Cloud Platform (GCP) with optional NAT, firewall rules, routes, and flow logs.





# This file is part of the Terraform configuration for managing Google Cloud resources.
# It specifies the main configuration for creating a VPC network, NAT gateway, firewall rules, routes, and flow logs.
# The configuration uses modules to create the VPC network, NAT gateway, firewall rules, routes, and flow logs.
# The modules are defined in separate directories and are sourced using the `source` attribute.
# The configuration is designed to be flexible and customizable, allowing users to specify the project ID, region, network name, subnets, NAT gateway, firewall rules, routes, and flow logs.

locals {
  network_name = var.network_name
}

module "vpc" {
  source     = "./modules/vpc"
  project_id = var.project_id
  name       = local.network_name
  subnets    = var.subnets
}

module "nat" {
  source       = "./modules/nat"
  count        = var.create_nat ? 1 : 0
  project_id   = var.project_id
  region       = var.region
  network_name = module.vpc.network_name
  nat_name     = var.nat_name
  
  # Get all the subnet names for the region to attach NAT to
  subnetworks = [
    for subnet in module.vpc.subnets : subnet.name
    if subnet.region == var.region
  ]
}

module "firewall" {
  source      = "./modules/firewall"
  project_id  = var.project_id
  network_name = module.vpc.network_name
  rules       = var.firewall_rules
}

module "routes" {
  source      = "./modules/routes"
  project_id  = var.project_id
  network_name = module.vpc.network_name
  routes      = var.routes
}

module "flow_logs" {
  source      = "./modules/flow-logs"
  count       = var.enable_flow_logs ? 1 : 0
  project_id  = var.project_id
  network_name = module.vpc.network_name
  subnets     = module.vpc.subnets
  config      = var.flow_logs_config
}