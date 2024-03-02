terraform {
  cloud {
    organization = "organization_name"
    workspaces {
      name = "gke_integration_dev"
    }
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.26.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.25.0"
    }
  }
}

provider "google" {
  project     = var.google_project_id
  region      = var.gke_region
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.primary.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
  )
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

module "letsencrypt" {
  source                  = "../../../modules/letsencrypt"
  cert_manager_acme_email = var.cert_manager_acme_email
  cloudflare_email        = var.cloudflare_email
  cloudflare_api_key      = var.cloudflare_api_key
}

module "cloudflare_dns" {
  source                    = "../../../modules/dns"
  cloudflare_zone_id        = var.cloudflare_zone_id
  cloudflare_record_name    = var.cloudflare_record_name
  cloudflare_record_type    = var.cloudflare_record_type
  cloudflare_record_ttl     = var.cloudflare_record_ttl
  cloudflare_record_proxied = var.cloudflare_record_proxied
  cloudflare_record_ssl     = var.cloudflare_record_ssl
}