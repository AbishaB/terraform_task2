# locals{
#     subnet_region = "us-west"
# }

#creating a vpc with default subnets
module "vpc" {
    source  = "../../modules/vpc"
    #version = "~> 3.0"

    project_id   = var.project_id
    network_name = "main-vpc"
    auto_create_subnetworks = true

    
}

#creating firewall rules for that VPC network
module "firewall_rules" {
#module "google_compute_firewall"{
  source       = "../../modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.vpc.network_name

  rules = [
      {
      name                    = "allow-ssh-ingress"
      description             = "allows ssh ingress for all vms"
      direction               = "INGRESS"
      priority                = 100
      ranges                  = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      },
      {
        protocol = "udp"
        ports    = ["22"]
      }
      ]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    },
    {
      name                    = "allow-smtp-ingress"
      description             = "allows smtp ingress for all vms"
      direction               = "INGRESS"
      priority                = 50
      ranges                  = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["25"]
      }
      ]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    }
    
  ]
}