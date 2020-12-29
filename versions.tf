terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    mailgun = {
      source = "terraform-providers/mailgun"
    }
  }
  required_version = ">= 0.13"
}
