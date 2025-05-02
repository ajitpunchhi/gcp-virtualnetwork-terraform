variable "project_id" {
  description = "The ID of the project where the VPC will be created"
  type        = string
}

variable "name" {
  description = "The name of the VPC network"
  type        = string
}

variable "auto_create_subnetworks" {
  description = "When set to true, the network is created in 'auto subnet mode'"
  type        = bool
  default     = false
}

variable "description" {
  description = "An optional description of the VPC network"
  type        = string
  default     = ""
}

variable "routing_mode" {
  description = "The network routing mode (GLOBAL or REGIONAL)"
  type        = string
  default     = "GLOBAL"
}

variable "delete_default_routes_on_create" {
  description = "If set to true, default routes (0.0.0.0/0) will be deleted immediately after network creation"
  type        = bool
  default     = false
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