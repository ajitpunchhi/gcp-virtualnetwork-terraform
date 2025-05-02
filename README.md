```markdown
# Terraform Module for GCP Networking

This module creates a complete networking setup on Google Cloud Platform (GCP), including:

- VPC Network
- Subnets
- Cloud NAT
- Firewall Rules
- Routes
- VPC Flow Logs

## Usage

```hcl
module "networking" {
  source = "github.com/example/gcp-networking-module"

  project_id   = "my-project"
  region       = "us-central1"
  network_name = "my-vpc"

  subnets = [
    {
      name          = "subnet-01"
      ip_cidr_range = "10.10.10.0/24"
      region        = "us-central1"
    }
  ]

  create_nat = true
  nat_name   = "my-nat"

  firewall_rules = [
    {
      name        = "allow-internal"
      description = "Allow internal traffic"
      direction   = "INGRESS"
      ranges      = ["10.10.10.0/24"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["0-65535"]
        }
      ]
    }
  ]

  routes = [
    {
      name              = "internet-route"
      description       = "Route to the Internet"
      destination_range = "0.0.0.0/0"
      next_hop_gateway  = "default-internet-gateway"
    }
  ]

  enable_flow_logs = true
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| google | >= 4.0.0 |
| google-beta | >= 4.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | The ID of the project where resources will be created | `string` | n/a | yes |
| region | The region where resources will be created | `string` | n/a | yes |
| network_name | The name of the VPC network | `string` | n/a | yes |
| subnets | The list of subnets to be created | `list(object)` | `[]` | no |
| create_nat | Whether to create a NAT gateway | `bool` | `false` | no |
| nat_name | The name of the NAT gateway | `string` | `"nat-gateway"` | no |
| firewall_rules | List of firewall rules to be created | `list(object)` | `[]` | no |
| routes | List of routes to be created | `list(object)` | `[]` | no |
| enable_flow_logs | Whether to enable VPC Flow Logs | `bool` | `false` | no |
| flow_logs_config | Configuration for VPC Flow Logs | `object` | See variables.tf | no |

## Outputs

| Name | Description |
|------|-------------|
| network | The created VPC network |
| network_name | The name of the VPC network |
| network_id | The ID of the VPC network |
| network_self_link | The self-link of the VPC network |
| subnets | The created subnets |
| subnet_ids | The IDs of the subnets |
| nat_gateway_ip | The external IP address of the NAT gateway |
| firewall_rules | The created firewall rules |
| routes | The created routes |
```