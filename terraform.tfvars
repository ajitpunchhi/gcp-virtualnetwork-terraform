# Project and region
project_id   = "my-gcp-project"
region       = "us-central1"
network_name = "prod-vpc"

# Subnet configurations
subnets = [
  {
    name           = "subnet-us-central1"
    ip_cidr_range  = "10.0.0.0/24"
    region         = "us-central1"
    private_access = true
    secondary_ip_ranges = [
      {
        range_name    = "pods"
        ip_cidr_range = "10.1.0.0/16"
      },
      {
        range_name    = "services"
        ip_cidr_range = "10.2.0.0/20"
      }
    ]
  },
  {
    name           = "subnet-us-west1"
    ip_cidr_range  = "10.10.0.0/24"
    region         = "us-west1"
    private_access = true
  }
]

# NAT configuration
create_nat  = true
nat_name    = "prod-nat"
# router_name attribute removed as it is not valid here

# Firewall rules
firewall_rules = [
  {
    name        = "allow-internal"
    description = "Allow internal traffic between instances"
    direction   = "INGRESS"
    ranges      = ["10.0.0.0/24", "10.10.0.0/24"]
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
    description = "Allow SSH from IAP"
    direction   = "INGRESS"
    ranges      = ["35.235.240.0/20"] # IAP range
    allow = [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
    target_tags = ["ssh"]
  },
  {
    name        = "allow-http-https"
    description = "Allow HTTP/HTTPS from anywhere"
    direction   = "INGRESS"
    ranges      = ["0.0.0.0/0"]
    allow = [
      {
        protocol = "tcp"
        ports    = ["80", "443"]
      }
    ]
    target_tags = ["web"]
  },
  {
    name        = "deny-internet-egress"
    description = "Deny egress to internet"
    direction   = "EGRESS"
    ranges      = ["0.0.0.0/0"]
    deny = [
      {
        protocol = "all"
      }
    ]
    target_tags = ["no-internet"]
  }
]

# Routes
routes = [
  {
    name              = "internet-route"
    description       = "Route to the Internet"
    destination_range = "0.0.0.0/0"
    next_hop_gateway  = "default-internet-gateway"
  },
  {
    name              = "private-route"
    description       = "Route to on-premises network"
    destination_range = "192.168.0.0/16"
    next_hop_ip       = "10.0.0.10" # VPN/Interconnect next hop
  }
]

# VPC Flow Logs
enable_flow_logs = true
flow_logs_config = {
  aggregation_interval = "INTERVAL_5_SEC"
  flow_sampling        = 0.5
  metadata             = "INCLUDE_ALL_METADATA"
}