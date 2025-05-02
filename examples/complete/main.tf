provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

module "networking" {
  source = "../../"

  project_id   = var.project_id
  region       = var.region
  network_name = "example-vpc"

  subnets = [
    {
      name          = "subnet-01"
      ip_cidr_range = "10.10.10.0/24"
      region        = var.region
      secondary_ip_ranges = [
        {
          range_name    = "pods"
          ip_cidr_range = "10.20.0.0/16"
        },
        {
          range_name    = "services"
          ip_cidr_range = "10.30.0.0/16"
        }
      ]
    },
    {
      name          = "subnet-02"
      ip_cidr_range = "10.10.20.0/24"
      region        = var.region
    }
  ]

  create_nat = true
  nat_name   = "example-nat"

  firewall_rules = [
    {
      name        = "allow-internal"
      description = "Allow internal traffic"
      direction   = "INGRESS"
      ranges      = ["10.10.10.0/24", "10.10.20.0/24"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["0-65535"]
        },
        {
          protocol = "udp"
          ports    = ["0-65535"]
        },
        {
          protocol = "icmp"
        }
      ]
    },
    {
      name        = "allow-ssh"
      description = "Allow SSH from anywhere"
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

  routes = [
    {
      name              = "internet-route"
      description       = "Route to the Internet"
      destination_range = "0.0.0.0/0"
      next_hop_gateway  = "default-internet-gateway"
    }
  ]

  enable_flow_logs = true
  flow_logs_config = {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}