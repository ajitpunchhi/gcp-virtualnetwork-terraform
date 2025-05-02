variable "project_id" {
  description = "The ID of the project where the NAT will be created"
  type        = string
}

variable "region" {
  description = "The region where the NAT will be created"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "nat_name" {
  description = "The name of the NAT gateway"
  type        = string
}

variable "nat_ip_allocate_option" {
  description = "How external IPs should be allocated for this NAT. Valid values: AUTO_ONLY, MANUAL_ONLY"
  type        = string
  default     = "AUTO_ONLY"
}

variable "source_subnetwork_ip_ranges_to_nat" {
  description = "How NAT should be configured per Subnetwork. Valid values: ALL_SUBNETWORKS_ALL_IP_RANGES, ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, LIST_OF_SUBNETWORKS"
  type        = string
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "subnetworks" {
  description = "List of subnetwork names which need NAT service"
  type        = list(string)
  default     = []
}

variable "min_ports_per_vm" {
  description = "Minimum number of ports allocated to a VM from this NAT"
  type        = number
  default     = 64
}

variable "nat_ips" {
  description = "List of self_links of external IPs. Required if nat_ip_allocate_option is MANUAL_ONLY"
  type        = list(string)
  default     = []
}

variable "enable_endpoint_independent_mapping" {
  description = "Specifies if endpoint independent mapping is enabled"
  type        = bool
  default     = true
}

variable "enable_dynamic_port_allocation" {
  description = "Enable dynamic port allocation"
  type        = bool
  default     = false
}

variable "log_config" {
  description = "Configuration for logging on NAT"
  type = object({
    enable = bool
    filter = string
  })
  default = {
    enable = false
    filter = "ALL"
  }
}