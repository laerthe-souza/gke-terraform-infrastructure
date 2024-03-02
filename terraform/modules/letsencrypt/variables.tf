variable "cloudflare_email" {
  type = string
  sensitive = true
}

variable "cloudflare_api_key" {
  type = string
  sensitive = true
}

variable "cert_manager_acme_email" {
  type = string
  sensitive = true
}
