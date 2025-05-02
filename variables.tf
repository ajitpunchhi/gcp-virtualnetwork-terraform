# This file defines the input variables for the VPC module.
# It includes variables for project ID, region, network name, subnets, NAT gateway, firewall rules, routes, and VPC Flow Logs.
# The variables are used to customize the VPC configuration and allow for flexibility in resource creation.
# The variables are defined with descriptions, types, and default values where applicable.
# The variables are used in the main Terraform configuration file to create and manage Google Cloud resources.
# This file is part of the Terraform configuration for managing Google Cloud resources.
# It specifies the input variables for the VPC module, including project ID, region, network name, subnets, NAT gateway, firewall rules, routes, and VPC Flow Logs.
# The variables are used to customize the VPC configuration and allow for flexibility in resource creation.
# The variables are defined with descriptions, types, and default values where applicable.
# The variables are used in the main Terraform configuration file to create and manage Google Cloud resources.
# This file defines the input variables for the VPC module.


variable "project_id" {
  description = "The ID of the project where resources will be created"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnets" {
  description = "The list of subnets to be created"
  type = list(object({
    name          = string
    ip_cidr_range = string
    region        = string
    secondary_ip_ranges = optional(list(object({
      range_name    = string
      ip_cidr_range = string
    })), [])
  }))
  default = []
}

variable "create_nat" {
  description = "Whether to create a NAT gateway"
  type        = bool
  default     = false
}

variable "nat_name" {
  description = "The name of the NAT gateway"
  type        = string
  default     = "nat-gateway"
}

variable "firewall_rules" {
  description = "List of firewall rules to be created"
  type = list(object({
    name        = string
    description = optional(string, "")
    direction   = optional(string, "INGRESS")
    priority    = optional(number, 1000)
    ranges      = list(string)
    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string), [])
    })), [])
    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string), [])
    })), [])
    source_tags             = optional(list(string), [])
    source_service_accounts = optional(list(string), [])
    target_tags             = optional(list(string), [])
    target_service_accounts = optional(list(string), [])
  }))
  default = []
}

variable "routes" {
  description = "List of routes to be created"
  type = list(object({
    name              = string
    description       = optional(string, "")
    destination_range = string
    next_hop_gateway  = optional(string, "")
    next_hop_ip       = optional(string, "")
    next_hop_instance = optional(string, "")
    next_hop_vpn_tunnel = optional(string, "")
    next_hop_ilb      = optional(string, "")
    priority          = optional(number, 1000)
    tags              = optional(list(string), [])
  }))
  default = []
}

variable "enable_flow_logs" {
  description = "Whether to enable VPC Flow Logs"
  type        = bool
  default     = false
}

variable "flow_logs_config" {
  description = "Configuration for VPC Flow Logs"
  type = object({
    aggregation_interval = optional(string, "INTERVAL_5_SEC")
    flow_sampling        = optional(number, 0.5)
    metadata             = optional(string, "INCLUDE_ALL_METADATA")
  })
  default = {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}