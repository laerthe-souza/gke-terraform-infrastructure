terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.25.0"
    }
  }
}

resource "cloudflare_record" "cloudflare_dns" {
  depends_on = [data.kubernetes_service.nginx_ingress]
  zone_id    = var.cloudflare_zone_id
  name       = var.cloudflare_record_name
  value      = data.kubernetes_service.nginx_ingress.status[0].load_balancer[0].ingress[0].ip
  type       = var.cloudflare_record_type
  ttl        = var.cloudflare_record_ttl
  proxied    = var.cloudflare_record_proxied
}

resource "cloudflare_zone_settings_override" "zone_settings" {
  zone_id = var.cloudflare_zone_id

  settings {
    ssl = var.cloudflare_record_ssl
  }
}