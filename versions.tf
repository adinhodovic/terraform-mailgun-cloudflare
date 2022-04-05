terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    mailgun = {
      source  = "wgebis/mailgun"
      version = ">= 0.7"
    }
  }
  required_version = ">= 1.0"
}
