# Google Cloud Platform Networking Terraform Module

A comprehensive Terraform module for creating and managing networking resources on Google Cloud Platform (GCP). This module provides a complete networking setup including VPC networks, subnets, Cloud NAT, firewall rules, routes, and VPC Flow Logs.

![gcp-networking-architecture](https://github.com/user-attachments/assets/d81a1f05-3000-4f7e-b82c-cf4661024517)


## Features

- **VPC Network**: Custom VPC networks with configurable routing modes
- **Subnets**: Multiple subnets across regions with secondary IP ranges
- **Cloud NAT**: Optional Cloud NAT with customizable router configuration
- **Firewall Rules**: Flexible firewall rule definitions with support for INGRESS/EGRESS
- **Routes**: Custom routing tables with multiple next-hop options
- **VPC Flow Logs**: Network monitoring with configurable sampling and aggregation
- **Modular Design**: Clean separation of concerns with individual modules

## Quick Start

```hcl
module "networking" {
  source = "github.com/your-username/gcp-networking-module"

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
  enable_flow_logs = true
}
```

## Architecture Overview

This module creates a fully managed networking infrastructure in GCP with the following components:

1. **VPC Network**: The foundational network container
2. **Subnets**: Regional subnets with optional secondary IP ranges
3. **Cloud NAT**: Provides internet access for private instances
4. **Firewall Rules**: Controls traffic flow based on protocols, ports, and tags
5. **Routes**: Defines network paths and next-hop destinations
6. **VPC Flow Logs**: Monitors and logs network flows for analysis

## Usage Examples

### Basic VPC with Subnets

```hcl
module "networking" {
  source = "./modules/networking"

  project_id   = "my-project"
  region       = "us-central1"
  network_name = "basic-vpc"

  subnets = [
    {
      name          = "web-subnet"
      ip_cidr_range = "10.0.0.0/24"
      region        = "us-central1"
    },
    {
      name          = "db-subnet"
      ip_cidr_range = "10.0.1.0/24"
      region        = "us-central1"
    }
  ]
}
```

### Advanced Setup with NAT and Firewall Rules

```hcl
module "networking" {
  source = "./modules/networking"

  project_id   = "my-project"
  region       = "us-central1"
  network_name = "advanced-vpc"

  subnets = [
    {
      name          = "prod-subnet"
      ip_cidr_range = "10.0.0.0/24"
      region        = "us-central1"
      secondary_ip_ranges = [
        {
          range_name    = "pods"
          ip_cidr_range = "10.1.0.0/16"
        }
      ]
    }
  ]

  create_nat = true
  nat_name   = "prod-nat"

  firewall_rules = [
    {
      name        = "allow-ssh"
      description = "Allow SSH access"
      direction   = "INGRESS"
      ranges      = ["0.0.0.0/0"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["22"]
        }
      ]
      target_tags = ["ssh"]
    }
  ]
}
```

## Module Structure

```
.
├── main.tf              # Main configuration
├── variables.tf         # Input variables
├── outputs.tf          # Output definitions
├── versions.tf         # Provider versions
├── modules/
│   ├── vpc/            # VPC and subnet resources
│   ├── nat/            # Cloud NAT configuration
│   ├── firewall/       # Firewall rule management
│   ├── routes/         # Custom route definitions
│   └── flow-logs/      # VPC Flow Logs setup
└── examples/
    └── complete/       # Complete example configuration
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | The ID of the GCP project | `string` | n/a | yes |
| region | The region where resources will be created | `string` | n/a | yes |
| network_name | The name of the VPC network | `string` | n/a | yes |
| subnets | List of subnets to be created | `list(object)` | `[]` | no |
| create_nat | Whether to create a NAT gateway | `bool` | `false` | no |
| nat_name | The name of the NAT gateway | `string` | `"nat-gateway"` | no |
| firewall_rules | List of firewall rules to be created | `list(object)` | `[]` | no |
| routes | List of routes to be created | `list(object)` | `[]` | no |
| enable_flow_logs | Whether to enable VPC Flow Logs | `bool` | `false` | no |
| flow_logs_config | Configuration for VPC Flow Logs | `object` | See variables.tf | no |

## Outputs

| Name | Description |
|------|-------------|
| network_name | The name of the VPC network |
| network_id | The ID of the VPC network |
| network_self_link | The self-link of the VPC network |
| subnets | The created subnets |
| subnet_ids | Map of subnet names to their IDs |
| nat_gateway_ip | The external IP address of the NAT gateway |
| firewall_rules | The created firewall rules |
| routes | The created routes |

## Requirements

- Terraform >= 1.0.0
- Google Provider >= 4.0.0
- Google Beta Provider >= 4.0.0

## Installation

```bash
git clone https://github.com/your-username/gcp-networking-module.git
cd gcp-networking-module

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply
```

## Best Practices

1. **Subnet Design**: Use appropriate CIDR ranges to avoid IP conflicts
2. **NAT Configuration**: Enable NAT for private instances that need internet access
3. **Firewall Rules**: Follow the principle of least privilege
4. **Flow Logs**: Enable for network troubleshooting and security monitoring
5. **Tagging**: Use consistent tags for resource organization

## Examples and Testing

Check the `examples/` directory for complete working examples:

- `examples/complete/`: Full-featured configuration with all components

To run tests:

```bash
cd examples/complete
terraform init
terraform plan
```

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This module is released under the MIT License. See [LICENSE](LICENSE) for details.

## Support

For support and questions:
- Create an issue in this repository
- Contact: support@example.com

## Acknowledgments

- Thanks to the Terraform community
- Built following GCP best practices

## Resources

- [GCP VPC Documentation](https://cloud.google.com/vpc/docs)
- [Terraform Google Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Cloud NAT Documentation](https://cloud.google.com/nat/docs)

---

Made with ❤️ for the cloud community
