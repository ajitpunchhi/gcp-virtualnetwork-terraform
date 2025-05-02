variable "project_id" {
  description = "The ID of the project where routes will be created"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
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