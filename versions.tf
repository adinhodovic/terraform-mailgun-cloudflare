terraform {
  required_providers {
    cloudflare = {
      source = "terraform-providers/cloudflare"
    }
    mailgun = {
      source = "terraform-providers/mailgun"
    }
  }
  required_version = ">= 0.13"
}
