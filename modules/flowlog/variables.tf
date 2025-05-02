variable "project_id" {
  description = "The ID of the project where flow logs will be enabled"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnets" {
  description = "The subnets where flow logs will be enabled"
  type        = map(any)
}

variable "config" {
  description = "Configuration for VPC Flow Logs"
  type = object({
    aggregation_interval = string
    flow_sampling        = number
    metadata             = string
  })
  default = {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}