variable "gke_cluster_name" {
  type = string
  default = "gke-cluster-dev"
}

variable "gke_region" {
  type = string
  default = "southamerica-east1-a"
}

variable "google_project_id" {
  type = string
}

variable "cert_manager_acme_email" {
  type    = string
  sensitive = true
}

variable "cloudflare_email" {
  type = string
  sensitive = true
}

variable "cloudflare_api_key" {
  type = string
  sensitive = true
}

variable "cloudflare_zone_id" {
  type    = string
  sensitive = true
}

variable "cloudflare_record_name" {
  type    = string
  default = "*"
}

variable "cloudflare_record_type" {
  type    = string
  default = "A"
}

variable "cloudflare_record_ttl" {
  type    = number
  default = 1
}

variable "cloudflare_record_proxied" {
  type    = bool
  default = false
}

variable "cloudflare_record_ssl" {
  type    = string
  default = "full"
}