variable "cloudflare_zone_id" {
  type = string
  sensitive = true
}

variable "cloudflare_record_name" {
  type = string
}

variable "cloudflare_record_type" {
  type = string
}

variable "cloudflare_record_ttl" {
  type = number
}

variable "cloudflare_record_proxied" {
  type = bool
}

variable "cloudflare_record_ssl" {
  type = string
}